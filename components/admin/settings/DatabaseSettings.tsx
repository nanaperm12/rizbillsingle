import React, { useState, useRef } from 'react';
import Card from '../../common/Card';
import { fetchWithAuth } from '~/components/api';

const API_URL = '/api/admin';
const DEFAULT_BACKUP_EXTENSION = '.riz';

const DatabaseSettings: React.FC = () => {
    const [isBackingUp, setIsBackingUp] = useState(false);
    const [isRestoring, setIsRestoring] = useState(false);
    const [feedback, setFeedback] = useState<{ type: 'success' | 'error', message: string } | null>(null);
    const fileInputRef = useRef<HTMLInputElement>(null);

    const handleBackup = async () => {
        setIsBackingUp(true);
        setFeedback(null);
        try {
            const normalizedExt = DEFAULT_BACKUP_EXTENSION;
            const res = await fetchWithAuth(`${API_URL}/database/backup?ext=${encodeURIComponent(normalizedExt)}`);
            if (!res.ok) {
                const errData = await res.json();
                throw new Error(errData.message || 'Failed to create backup.');
            }
            const blob = await res.blob();
            const url = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            const date = new Date().toLocaleDateString('en-CA');
            a.download = `backup-${date}${normalizedExt}`;
            document.body.appendChild(a);
            a.click();
            a.remove();
            window.URL.revokeObjectURL(url);

            setFeedback({ type: 'success', message: 'Backup downloaded successfully!' });
        } catch (error: any) {
            setFeedback({ type: 'error', message: error.message });
        } finally {
            setIsBackingUp(false);
        }
    };

    const handleRestoreClick = () => {
        fileInputRef.current?.click();
    };

    const handleFileChange = async (event: React.ChangeEvent<HTMLInputElement>) => {
        const file = event.target.files?.[0];
        if (!file) return;

        if (!window.confirm('Are you sure you want to restore the database from this file? This action is irreversible and will OVERWRITE ALL existing data.')) {
            if (fileInputRef.current) {
                fileInputRef.current.value = '';
            }
            return;
        }

        setIsRestoring(true);
        setFeedback(null);
        const formData = new FormData();
        formData.append('backup', file);

        try {
            const res = await fetchWithAuth(`${API_URL}/database/restore`, {
                method: 'POST',
                body: formData,
            });

            const data = await res.json();
            if (!res.ok) {
                throw new Error(data.message || 'Failed to restore database.');
            }
            setFeedback({ type: 'success', message: data.message });
        } catch (error: any) {
            setFeedback({ type: 'error', message: error.message });
        } finally {
            setIsRestoring(false);
            if (fileInputRef.current) {
                fileInputRef.current.value = '';
            }
        }
    };

    return (
        <Card title="Database Management">
            <div className="space-y-6">
                {feedback && (
                    <div className={`p-3 rounded-md text-sm ${feedback.type === 'success' ? 'bg-green-100 dark:bg-green-900/50 text-green-800 dark:text-green-300' : 'bg-red-100 dark:bg-red-900/50 text-red-800 dark:text-red-300'}`}>
                        {feedback.message}
                    </div>
                )}
                <div className="border p-4 rounded-md dark:border-gray-700 space-y-3">
                    <h3 className="font-semibold text-lg text-gray-800 dark:text-gray-200">Backup</h3>
                    <p className="text-sm text-gray-600 dark:text-gray-400">
                        Download a full backup of the MySQL database. The export is always standard SQL and will be
                        saved with the default <code>.riz</code> extension for consistency.
                    </p>
                    <button
                        onClick={handleBackup}
                        disabled={isBackingUp}
                        className="px-4 py-2 bg-blue-600 text-white rounded-md hover:bg-blue-700 font-semibold shadow-sm transition-colors flex items-center disabled:bg-blue-400"
                    >
                        {isBackingUp && <svg className="animate-spin -ml-1 mr-3 h-5 w-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle><path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>}
                        {isBackingUp ? 'Backing up...' : 'Download Database Backup'}
                    </button>
                </div>

                 <div className="border border-red-400 dark:border-red-600 p-4 rounded-md space-y-3">
                    <h3 className="font-semibold text-lg text-red-700 dark:text-red-400">Restore</h3>
                     <p className="text-sm text-gray-600 dark:text-gray-400">
                        <strong className="font-bold">Warning:</strong> Restoring from an SQL file will completely overwrite and replace all current data in the database. This action is irreversible and cannot be undone. Proceed with extreme caution.
                    </p>
                    <button
                        onClick={handleRestoreClick}
                        disabled={isRestoring}
                        className="px-4 py-2 bg-red-600 text-white rounded-md hover:bg-red-700 font-semibold shadow-sm transition-colors flex items-center disabled:bg-red-400"
                    >
                         {isRestoring && <svg className="animate-spin -ml-1 mr-3 h-5 w-5" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24"><circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle><path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path></svg>}
                        {isRestoring ? 'Restoring...' : 'Restore from Backup'}
                    </button>
                    <input
                        type="file"
                        ref={fileInputRef}
                        onChange={handleFileChange}
                        className="hidden"
                    />
                </div>
            </div>
        </Card>
    );
};

export default DatabaseSettings;
