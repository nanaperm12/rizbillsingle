
import React, { useState, useEffect, useMemo, useCallback } from 'react';
import Card from '../../components/common/Card';
import { AcsDevice, formatDateTimeDisplay } from '../../types';
import AcsDeviceDetailModal from '../../components/admin/AcsDeviceDetailModal';
import DeleteConfirmationModal from '../../components/common/DeleteConfirmationModal';
import { fetchWithAuth } from '~/components/api';

const API_URL = '/api/acs';

const RxPowerDisplay: React.FC<{ rxPower: string }> = ({ rxPower }) => {
    if (rxPower === 'N/A') {
        return <span className="text-gray-400">N/A</span>;
    }
    
    const powerValue = parseFloat(rxPower);
    if (isNaN(powerValue)) {
        return <span className="text-gray-400">{rxPower}</span>;
    }
    
    let colorClass = 'text-gray-800 dark:text-gray-200';
    if (powerValue > -25) {
        colorClass = 'text-green-600 dark:text-green-400';
    } else if (powerValue >= -28) {
        colorClass = 'text-yellow-600 dark:text-yellow-400';
    } else {
        colorClass = 'text-red-600 dark:text-red-400';
    }
    
    return <span className={`font-semibold ${colorClass}`}>{rxPower}</span>;
};

// --- Icon Components ---
const BellIcon = () => <svg xmlns="http://www.w3.org/2000/svg" className="h-3 w-3" viewBox="0 0 20 20" fill="currentColor"><path d="M10 2a6 6 0 00-6 6v3.586l-.707.707A1 1 0 004 14h12a1 1 0 00.707-1.707L16 11.586V8a6 6 0 00-6-6zM10 18a3 3 0 01-3-3h6a3 3 0 01-3 3z" /></svg>;
const SpinnerIcon = () => <svg className="animate-spin h-3 w-3" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle><path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>;
const TrashIcon = () => <svg xmlns="http://www.w3.org/2000/svg" className="h-4 w-4" viewBox="0 0 20 20" fill="currentColor"><path fillRule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clipRule="evenodd" /></svg>;
const CloseIcon = () => <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" /></svg>;


const formatRelativeTime = (date: Date | null): string => {
    if (!date) return 'never';
    const now = new Date();
    const seconds = Math.floor((now.getTime() - date.getTime()) / 1000);

    if (seconds < 60) return `${seconds} sec ago`;
    const minutes = Math.floor(seconds / 60);
    if (minutes < 60) return `${minutes} min ago`;
    const hours = Math.floor(minutes / 60);
    if (hours < 24) return `${hours} hr ago`;
    const days = Math.floor(hours / 24);
    return `${days} day(s) ago`;
};

const encodeAcsDeviceId = (deviceId: string) => encodeURIComponent(String(deviceId ?? '').trim());


const AcsDevices: React.FC = () => {
    const [devices, setDevices] = useState<AcsDevice[]>([]);
    const [isLoading, setIsLoading] = useState(true);
    const [isSyncing, setIsSyncing] = useState(false);
    const [isRefreshing, setIsRefreshing] = useState(false);
    const [error, setError] = useState<string | null>(null);
    const [searchQuery, setSearchQuery] = useState('');
    const [summoningDevice, setSummoningDevice] = useState<string | null>(null);
    const [viewingDevice, setViewingDevice] = useState<AcsDevice | null>(null);
    const [lastSyncTime, setLastSyncTime] = useState<Date | null>(null);

    // State for bulk actions
    const [selectedDevices, setSelectedDevices] = useState<string[]>([]);
    const [deletingMode, setDeletingMode] = useState<'bulk' | null>(null);
    const [isDeleting, setIsDeleting] = useState(false);

    // Pagination state
    const [currentPage, setCurrentPage] = useState(1);
    const ITEMS_PER_PAGE = 20;
    
    const sortDevices = (deviceList: AcsDevice[]) => {
        return deviceList.sort((a, b) => {
            if (a.isOnline && !b.isOnline) return -1;
            if (!a.isOnline && b.isOnline) return 1;
            if (!a.lastInform) return 1;
            if (!b.lastInform) return -1;
            return new Date(b.lastInform).getTime() - new Date(a.lastInform).getTime()
        });
    };

    const fetchCachedData = useCallback(async () => {
        setIsLoading(true);
        setError(null);
        try {
            const res = await fetchWithAuth(`${API_URL}/devices/cached`);
            if (!res.ok) {
                const errorData = await res.json();
                throw new Error(errorData.message || 'Failed to fetch cached ACS devices.');
            }
            const data = await res.json();
            
            const deviceList = Array.isArray(data) ? data : data.devices;
    
            if (Array.isArray(deviceList)) {
                setDevices(sortDevices(deviceList));
            } else {
                console.warn("Received unexpected data structure for cached devices:", data);
                setDevices([]); 
            }
    
            if (data.lastSyncTime) {
                setLastSyncTime(new Date(data.lastSyncTime));
            }
        } catch (err: any) {
            setError(err.message);
        } finally {
            setIsLoading(false);
        }
    }, []);
    
    useEffect(() => {
        fetchCachedData();
    }, [fetchCachedData]);

    const handleRefresh = useCallback(async () => {
        setIsRefreshing(true);
        setError(null);
        try {
            const res = await fetchWithAuth(`${API_URL}/devices`); // Fetch live data
            if (!res.ok) throw new Error((await res.json()).message || 'Failed to refresh live data.');
            const data = await res.json();
            
            const deviceList = Array.isArray(data) ? data : data.devices;
    
            if (Array.isArray(deviceList)) {
                setDevices(sortDevices(deviceList));
            } else {
                console.warn("Received unexpected data structure for live devices:", data);
                setDevices([]); 
            }
        } catch (err: any) {
            setError(err.message);
        } finally {
            setIsRefreshing(false);
        }
    }, []);

    const handleFullSync = useCallback(async () => {
        setIsSyncing(true);
        setError(null);
        try {
            const res = await fetchWithAuth(`${API_URL}/sync`, { method: 'POST' });
            if (!res.ok) throw new Error((await res.json()).message || 'Failed to sync with ACS server.');
            const data = await res.json();
            alert(data.message || 'Sync started. Devices are being updated in the background.');
            await fetchCachedData(); 
        } catch (err: any) {
            setError(err.message);
        } finally {
            setIsSyncing(false);
        }
    }, [fetchCachedData]);


    const handleSummon = async (e: React.MouseEvent, device: AcsDevice) => {
        e.stopPropagation();
        
        setSummoningDevice(device.id);
        setError(null);
        try {
            const encodedId = encodeAcsDeviceId(device.id);
            const parametersToSummon = [
                'InternetGatewayDevice.LANDevice.*.WLANConfiguration',
                'InternetGatewayDevice.LANInterfaces.WLANConfiguration',
            ];

            const res = await fetchWithAuth(`${API_URL}/devices/${encodedId}/summon`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ parameters: parametersToSummon }),
            });
            const data = await res.json();
            if (!res.ok) throw new Error(data.message || 'Failed to summon device.');
            alert("A 'Get Parameters' command has been sent to the device. The list will be updated in 10 seconds to show the latest data.");
            setTimeout(handleRefresh, 10000);
        } catch (err: any) {
            setError(err.message);
        } finally {
            setSummoningDevice(null);
        }
    };

    const confirmDelete = async () => {
        if (deletingMode !== 'bulk' || selectedDevices.length === 0) return;

        setIsDeleting(true);
        setError(null);
        try {
            const res = await fetchWithAuth(`${API_URL}/devices/bulk-delete`, {
                method: 'POST',
                body: JSON.stringify({ ids: selectedDevices }),
            });
            const data = await res.json();
            if (!res.ok) throw new Error(data.message || 'Failed to delete devices.');
            
            alert(data.message);
            setSelectedDevices([]);
            await handleRefresh();
        } catch (err: any) {
            setError(err.message);
        } finally {
            setIsDeleting(false);
            setDeletingMode(null);
        }
    };


    const filteredDevices = useMemo(() => {
        const lowercasedQuery = searchQuery.toLowerCase();
        if (!lowercasedQuery) return devices;
        return devices.filter(d =>
            d.serialNumber.toLowerCase().includes(lowercasedQuery) ||
            (d.customerName || '').toLowerCase().includes(lowercasedQuery) ||
            (d.pppoeUsername || '').toLowerCase().includes(lowercasedQuery) ||
            (d.ipAddress || '').toLowerCase().includes(lowercasedQuery) ||
            (d.productClass || '').toLowerCase().includes(lowercasedQuery) ||
            (d.rxPower || '').toLowerCase().includes(lowercasedQuery)
        );
    }, [devices, searchQuery]);

    const onlineCount = useMemo(() => devices.filter(d => d.isOnline).length, [devices]);

    useEffect(() => {
        setCurrentPage(1);
    }, [searchQuery]);

    const totalPages = Math.ceil(filteredDevices.length / ITEMS_PER_PAGE);
    const paginatedDevices = useMemo(() => {
        const startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
        return filteredDevices.slice(startIndex, startIndex + ITEMS_PER_PAGE);
    }, [filteredDevices, currentPage]);

    const handleSelectOne = (deviceId: string, isSelected: boolean) => {
        setSelectedDevices(prev => 
            isSelected ? [...prev, deviceId] : prev.filter(id => id !== deviceId)
        );
    };

    const handleSelectAll = (e: React.ChangeEvent<HTMLInputElement>) => {
        const pageIds = paginatedDevices.map(d => d.serialNumber);
        if (e.target.checked) {
            setSelectedDevices(prev => [...new Set([...prev, ...pageIds])]);
        } else {
            setSelectedDevices(prev => prev.filter(id => !pageIds.includes(id)));
        }
    };
    
    const areAllOnPageSelected = paginatedDevices.length > 0 && paginatedDevices.every(d => selectedDevices.includes(d.serialNumber));

    return (
        <div className="space-y-6">
            <AcsDeviceDetailModal
                isOpen={!!viewingDevice}
                onClose={() => setViewingDevice(null)}
                device={viewingDevice}
            />
             <DeleteConfirmationModal
                isOpen={deletingMode === 'bulk'}
                onClose={() => setDeletingMode(null)}
                onConfirm={confirmDelete}
                itemName={`${selectedDevices.length} device(s)`}
                itemType="ACS Device"
                isLoading={isDeleting}
            />

            <div className="flex justify-between items-start flex-wrap gap-4">
                <h2 className="text-2xl font-bold text-gray-800 dark:text-gray-100">ACS Devices</h2>
                <div className="flex items-center space-x-2">
                     <button
                        onClick={handleRefresh}
                        disabled={isSyncing || isRefreshing}
                        className="bg-gray-600 text-white px-4 py-2 rounded-md hover:bg-gray-700 font-semibold shadow-sm transition-colors disabled:bg-gray-400 flex items-center"
                    >
                        {isRefreshing && <SpinnerIcon />}
                        {isRefreshing ? 'Refreshing...' : 'Refresh Live Data'}
                    </button>
                    <button
                        onClick={handleFullSync}
                        disabled={isSyncing || isRefreshing}
                        className="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 font-semibold shadow-sm transition-colors disabled:bg-gray-400 flex items-center"
                    >
                        {isSyncing && <SpinnerIcon />}
                        {isSyncing ? 'Syncing...' : 'Full Sync (Update to ONT)'}
                    </button>
                </div>
            </div>

            {error && <div className="p-4 bg-red-100 dark:bg-red-900/40 border-l-4 border-red-500 text-red-700 dark:text-red-300 rounded-md">{error}</div>}
            
            <Card>
                <div className="p-4 border-b dark:border-gray-700 space-y-4">
                    <div className="flex flex-col sm:flex-row justify-between items-center gap-4">
                        <input
                            type="text"
                            placeholder="Search by Serial, Customer, PPPoE, IP, or Product..."
                            value={searchQuery}
                            onChange={(e) => setSearchQuery(e.target.value)}
                            className="pl-4 pr-4 py-2 border dark:border-gray-600 rounded-md w-full sm:w-96 bg-white dark:bg-gray-800 dark:text-white"
                        />
                        <div className="flex items-center space-x-4 text-sm font-semibold">
                            <span className="text-gray-600 dark:text-gray-300">Total: {devices.length}</span>
                            <span className="text-green-600 dark:text-green-400">Online: {onlineCount}</span>
                             <span className="text-xs text-gray-500 dark:text-gray-400" title={lastSyncTime?.toLocaleString()}>
                                Last sync: {formatRelativeTime(lastSyncTime)}
                            </span>
                        </div>
                    </div>
                    {selectedDevices.length > 0 && (
                        <div className="flex items-center justify-start gap-4 bg-gray-100 dark:bg-gray-700 p-3 rounded-md">
                            <span className="text-sm font-semibold text-gray-700 dark:text-gray-200">
                                {selectedDevices.length} selected
                            </span>
                            <button onClick={() => setDeletingMode('bulk')} disabled={isDeleting} className="flex items-center gap-2 px-3 py-1.5 text-sm font-medium text-white bg-red-600 rounded-md hover:bg-red-700 transition-colors shadow-sm disabled:bg-red-400">
                                <TrashIcon /> <span>Delete Selected</span>
                            </button>
                            <button onClick={() => setSelectedDevices([])} className="ml-auto p-1.5 text-gray-500 dark:text-gray-400 hover:bg-gray-200 dark:hover:bg-gray-600 rounded-full" aria-label="Clear selection">
                                <CloseIcon />
                            </button>
                        </div>
                    )}
                </div>
                
                <div className="overflow-x-auto">
                    <table className="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                        <thead className="bg-gray-50 dark:bg-gray-700/50">
                            <tr>
                                <th className="p-4">
                                     <input
                                        type="checkbox"
                                        className="h-4 w-4 rounded border-gray-300 dark:border-gray-600 text-blue-600 focus:ring-blue-500"
                                        onChange={handleSelectAll}
                                        checked={areAllOnPageSelected}
                                    />
                                </th>
                                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">Status / Action</th>
                                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">Serial Number</th>
                                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">Model</th>
                                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">Customer</th>
                                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">RX Power</th>
                                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">Wi-Fi</th>
                                <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">IP / PPPoE</th>
                            </tr>
                        </thead>
                        <tbody className="bg-white dark:bg-gray-800 divide-y divide-gray-200 dark:divide-gray-700">
                            {isLoading && (
                                <tr>
                                    <td colSpan={8} className="px-6 py-10 text-center text-gray-500 dark:text-gray-400">
                                        Loading devices...
                                    </td>
                                </tr>
                            )}
                            
                            {!isLoading && paginatedDevices.length === 0 && (
                                <tr>
                                    <td colSpan={8} className="px-6 py-10 text-center text-gray-500 dark:text-gray-400">
                                        No devices found. {devices.length === 0 && "Try syncing to fetch devices."}
                                    </td>
                                </tr>
                            )}

                            {!isLoading && paginatedDevices.map(device => (
                                <tr key={device.serialNumber} className={`hover:bg-gray-50 dark:hover:bg-gray-700 ${selectedDevices.includes(device.serialNumber) ? 'bg-blue-50 dark:bg-blue-900/30' : ''}`}>
                                    <td className="p-4" onClick={(e) => e.stopPropagation()}>
                                        <input
                                            type="checkbox"
                                            className="h-4 w-4 rounded border-gray-300 dark:border-gray-600 text-blue-600 focus:ring-blue-500"
                                            checked={selectedDevices.includes(device.serialNumber)}
                                            onChange={(e) => handleSelectOne(device.serialNumber, e.target.checked)}
                                        />
                                    </td>
                                    <td className="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                        <div className="flex flex-col gap-2 items-start">
                                             {device.isOnline ? (
                                                <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800 dark:bg-green-900/50 dark:text-green-300 w-fit">
                                                    <span className="w-2 h-2 mr-1 bg-green-500 rounded-full animate-pulse"></span>
                                                    Online
                                                </span>
                                            ) : (
                                                <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800 dark:bg-red-900/50 dark:text-red-300 w-fit">
                                                    Offline
                                                </span>
                                            )}

                                            <button
                                                onClick={(e) => handleSummon(e, device)}
                                                disabled={summoningDevice === device.id}
                                                className="bg-indigo-600 text-white hover:bg-indigo-700 dark:bg-indigo-500 dark:hover:bg-indigo-600 px-3 py-1 rounded-md text-xs font-semibold shadow-sm transition-colors flex items-center justify-center disabled:opacity-50 disabled:cursor-not-allowed w-fit"
                                                title="Summon / Get Parameters"
                                            >
                                                {summoningDevice === device.id ? <SpinnerIcon /> : <BellIcon />}
                                                <span className="ml-1">Summon</span>
                                            </button>
                                        </div>
                                    </td>
                                    <td className="px-6 py-4 whitespace-nowrap">
                                        <button onClick={() => setViewingDevice(device)} className="text-sm font-medium text-blue-600 dark:text-blue-400 hover:underline font-mono">
                                            {device.serialNumber}
                                        </button>
                                        <p className="text-xs text-gray-400" title={device.lastInform ? `Last inform: ${formatDateTimeDisplay(device.lastInform)}` : 'Never informed'}>
                                            {formatRelativeTime(device.lastInform ? new Date(device.lastInform) : null)}
                                        </p>
                                    </td>
                                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500 dark:text-gray-400">{device.productClass}</td>
                                    <td className="px-6 py-4 whitespace-nowrap">
                                        {device.customerName ? (
                                            <span className="text-sm font-semibold text-gray-800 dark:text-gray-200">{device.customerName}</span>
                                        ) : (
                                            <span className="text-xs text-gray-400 italic">Unlinked</span>
                                        )}
                                    </td>
                                    <td className="px-6 py-4 whitespace-nowrap text-sm">
                                        <RxPowerDisplay rxPower={device.rxPower} />
                                    </td>
                                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500 dark:text-gray-400">
                                        <div className="flex flex-col gap-1">
                                            <span title="SSID 1 (2.4GHz)" className={device.ssid1 ? 'text-gray-800 dark:text-gray-200' : 'text-gray-400'}>{device.ssid1 || '-'}</span>
                                            {device.ssid1Connected !== undefined && device.ssid1Connected > 0 && (
                                                <span className="text-xs text-green-600 dark:text-green-400">{device.ssid1Connected} clients</span>
                                            )}
                                        </div>
                                    </td>
                                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500 dark:text-gray-400">
                                        <div className="flex flex-col">
                                            <span className="font-mono">{device.ipAddress || '-'}</span>
                                            {device.pppoeUsername && <span className="text-xs text-gray-400">{device.pppoeUsername}</span>}
                                        </div>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
                 <div className="flex items-center justify-between p-4 border-t dark:border-gray-700">
                    <span className="text-sm text-gray-700 dark:text-gray-300">
                        Showing {Math.min((currentPage - 1) * ITEMS_PER_PAGE + 1, filteredDevices.length)}
                        {' to '}
                        {Math.min(currentPage * ITEMS_PER_PAGE, filteredDevices.length)}
                        {' of '}
                        {filteredDevices.length} results
                    </span>
                    <div className="flex items-center gap-2">
                        <button
                            onClick={() => setCurrentPage(prev => Math.max(prev - 1, 1))}
                            disabled={currentPage === 1}
                            className="px-3 py-1.5 text-sm font-medium text-gray-600 bg-white border border-gray-300 rounded-md hover:bg-gray-100 disabled:opacity-50 disabled:cursor-not-allowed dark:bg-gray-800 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-gray-700"
                        >
                            Previous
                        </button>
                        <span className="text-sm font-medium text-gray-700 dark:text-gray-300">
                            Page {currentPage} of {totalPages > 0 ? totalPages : 1}
                        </span>
                        <button
                            onClick={() => setCurrentPage(prev => Math.min(prev + 1, totalPages))}
                            disabled={currentPage === totalPages || totalPages === 0}
                            className="px-3 py-1.5 text-sm font-medium text-gray-600 bg-white border border-gray-300 rounded-md hover:bg-gray-100 disabled:opacity-50 disabled:cursor-not-allowed dark:bg-gray-800 dark:border-gray-600 dark:text-gray-300 dark:hover:bg-gray-700"
                        >
                            Next
                        </button>
                    </div>
                </div>
            </Card>
        </div>
    );
};

export default AcsDevices;
