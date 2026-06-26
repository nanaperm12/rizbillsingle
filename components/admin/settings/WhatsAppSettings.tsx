import React from 'react';
import Card from '../../common/Card';
import { ApiSettings } from '../../../types';

type WhatsAppStatus = { status: 'disconnected' | 'connecting' | 'connected' | 'qr' | 'error' | 'standby', user?: { id: string, name: string } };
type TestMessageStatus = 'idle' | 'sending' | 'success' | 'error';

interface WhatsAppSettingsProps {
    whatsappSettings: ApiSettings['whatsapp'];
    otpSettings: ApiSettings['otp'];
    waStatus: WhatsAppStatus;
    waQr: string | null;
    handleInputChange: (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement | HTMLSelectElement>) => void;
    handleWaLogout: () => void;
    testPhone: string;
    setTestPhone: (value: string) => void;
    handleSendTestMessage: () => void;
    testMsgStatus: TestMessageStatus;
    testMsgResponse: string;
    isChatbotConfigured: boolean;
}

const WhatsAppSettings: React.FC<WhatsAppSettingsProps> = ({
    whatsappSettings,
    otpSettings,
    waStatus,
    waQr,
    handleInputChange,
    handleWaLogout,
    testPhone,
    setTestPhone,
    handleSendTestMessage,
    testMsgStatus,
    testMsgResponse,
    isChatbotConfigured,
}) => {
    const inputClasses = "w-full p-2 border rounded bg-gray-50 dark:bg-gray-700 dark:border-gray-600 focus:ring-blue-500 focus:border-blue-500 dark:text-white dark:placeholder-gray-400";
    const textAreaClasses = `mt-1 block w-full p-2 border rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 ${inputClasses}`;
    const placeholderClasses = "text-xs font-mono p-0.5 bg-gray-200 dark:bg-gray-600 rounded-sm";

    const Placeholders: React.FC<{ keys: string[] }> = ({ keys }) => (
        <p className="mt-2 text-xs text-gray-500 dark:text-gray-400">
            Placeholders: {keys.map(key => <code key={key} className={placeholderClasses}>{`{{${key}}}`}</code>).reduce((prev, curr) => <>{prev}, {curr}</>)}
        </p>
    );


    return (
        <div className="space-y-6">
            <Card title="WhatsApp Connection">
                <div className="flex flex-col md:flex-row items-start gap-6">
                    <div className="flex-1 space-y-3">
                        <div className="flex items-center">
                            <input
                                type="checkbox"
                                id="standbyEnabled"
                                name="whatsapp.standbyEnabled"
                                checked={whatsappSettings?.standbyEnabled || false}
                                onChange={handleInputChange}
                                className="h-4 w-4 text-blue-600 border-gray-300 dark:border-gray-600 rounded focus:ring-blue-500"
                            />
                            <label htmlFor="standbyEnabled" className="ml-2 block text-sm font-medium text-gray-900 dark:text-gray-200">
                                Mode Standby (tidak konek ke WhatsApp)
                            </label>
                        </div>
                        <p className="text-xs text-gray-500 dark:text-gray-400">
                            Saat aktif, server tidak akan login atau mempertahankan koneksi WhatsApp.
                        </p>
                        <p className="text-sm font-medium text-gray-700 dark:text-gray-300">Connection Status:</p>
                        {waStatus.status === 'connected' && (
                            <div className="p-3 rounded-md bg-green-100 text-green-800 dark:bg-green-900/50 dark:text-green-300 text-sm flex items-center">
                                <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5 mr-2" viewBox="0 0 20 20" fill="currentColor"><path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" /></svg>
                                <div>
                                    <strong>Connected</strong>
                                    {waStatus.user && <span className="block text-xs">As: {waStatus.user.name} ({waStatus.user.id.split(':')[0]})</span>}
                                </div>
                            </div>
                        )}
                        {waStatus.status === 'connecting' && <div className="p-3 rounded-md bg-blue-100 text-blue-800 dark:bg-blue-900/50 dark:text-blue-300 text-sm"><strong>Connecting...</strong></div>}
                        {waStatus.status === 'disconnected' && <div className="p-3 rounded-md bg-gray-100 text-gray-800 dark:bg-gray-700 dark:text-gray-200 text-sm"><strong>Disconnected</strong></div>}
                        {waStatus.status === 'standby' && <div className="p-3 rounded-md bg-yellow-100 text-yellow-800 dark:bg-yellow-800/50 dark:text-yellow-300 text-sm"><strong>Standby</strong></div>}
                        {waStatus.status === 'qr' && <div className="p-3 rounded-md bg-yellow-100 text-yellow-800 dark:bg-yellow-800/50 dark:text-yellow-300 text-sm"><strong>Action Required:</strong> Please scan the QR code.</div>}
                        {waStatus.status === 'error' && <div className="p-3 rounded-md bg-red-100 text-red-800 dark:bg-red-900/50 dark:text-red-300 text-sm"><strong>Error:</strong> Could not connect to WhatsApp.</div>}
                        
                        <div className="pt-2">
                        {waStatus.status === 'connected' ? (
                            <button type="button" onClick={handleWaLogout} className="w-full sm:w-auto inline-flex justify-center items-center px-4 py-2 border border-red-300 dark:border-red-600 shadow-sm text-sm font-medium rounded-md text-red-700 dark:text-red-300 bg-white dark:bg-gray-800 hover:bg-red-50 dark:hover:bg-red-900/50">Disconnect</button>
                        ) : (
                            <p className="text-xs text-gray-500 dark:text-gray-400">
                                {waStatus.status === 'standby'
                                    ? 'Mode standby aktif. Nonaktifkan untuk konek ke WhatsApp.'
                                    : (waStatus.status === 'disconnected' ? 'Server is attempting to reconnect...' : 'Please wait...')}
                            </p>
                        )}
                        </div>
                    </div>
                    <div className="flex-shrink-0 w-full md:w-56 h-56 bg-gray-100 dark:bg-gray-700 rounded-lg flex items-center justify-center">
                        {waQr ? (
                            <img src={waQr} alt="Scan to connect WhatsApp" className="w-full h-full object-contain p-2" />
                        ) : (
                            <p className="text-sm text-gray-500 dark:text-gray-400 text-center px-4">
                                {waStatus.status === 'connecting' && "Generating QR Code..."}
                                {waStatus.status === 'connected' && "Connection established."}
                                {waStatus.status === 'standby' && "Standby aktif. QR tidak tersedia."}
                                {waStatus.status !== 'connecting' && waStatus.status !== 'connected' && waStatus.status !== 'standby' && "QR code will appear here during connection."}
                            </p>
                        )}
                    </div>
                </div>
                <div className="mt-6 border-t dark:border-gray-700 pt-4">
                    <h4 className="text-md font-medium text-gray-800 dark:text-gray-200 mb-2">Send Test Message</h4>
                     <div className="flex items-start space-x-2">
                        <input
                            type="tel"
                            value={testPhone}
                            onChange={(e) => setTestPhone(e.target.value)}
                            placeholder="Enter phone number (e.g., 62812...)"
                            className={`block w-full max-w-xs ${inputClasses}`}
                        />
                        <button
                            type="button"
                            onClick={handleSendTestMessage}
                            disabled={testMsgStatus === 'sending' || waStatus.status !== 'connected'}
                            className="inline-flex justify-center items-center px-4 py-2 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 disabled:bg-blue-400 disabled:cursor-not-allowed"
                        >
                            {testMsgStatus === 'sending' ? 'Sending...' : 'Send Test'}
                        </button>
                    </div>
                     {testMsgResponse && (
                        <p className={`mt-2 text-sm ${testMsgStatus === 'error' ? 'text-red-600 dark:text-red-400' : 'text-green-600 dark:text-green-400'}`}>
                            {testMsgResponse}
                        </p>
                    )}
                    <p className="mt-2 text-xs text-gray-500 dark:text-gray-400">Sends a predefined test message. WhatsApp must be connected.</p>
                </div>
                <div className="mt-6 border-t dark:border-gray-700 pt-4">
                    <h4 className="text-md font-medium text-gray-800 dark:text-gray-200 mb-2">WhatsApp Chatbot</h4>
                     <div className="flex items-center">
                        <input
                            type="checkbox"
                            id="chatbotEnabled"
                            name="whatsapp.chatbotEnabled"
                            checked={whatsappSettings?.chatbotEnabled || false}
                            onChange={handleInputChange}
                            className="h-4 w-4 text-blue-600 border-gray-300 dark:border-gray-600 rounded focus:ring-blue-500"
                        />
                        <label htmlFor="chatbotEnabled" className="ml-2 block text-sm font-medium text-gray-900 dark:text-gray-200">
                            Enable AI Chatbot
                        </label>
                    </div>
                     {whatsappSettings?.chatbotEnabled && !isChatbotConfigured && (
                        <div className="mt-3 p-3 bg-red-100 text-red-800 dark:bg-red-900/40 dark:text-red-300 rounded-md text-sm">
                            <strong>Warning:</strong> The chatbot is enabled, but the Gemini API Key is not configured on the server. The chatbot will not be active. Please see the "Gemini AI" tab for configuration instructions.
                        </div>
                    )}
                     <p className="text-xs text-gray-500 dark:text-gray-400 mt-1">
                        When enabled, the system will use Google Gemini to automatically respond to customer messages on this WhatsApp number, allowing for self-service actions like rebooting devices or changing Wi-Fi passwords.
                    </p>
                </div>
            </Card>

             <Card title="WhatsApp Message Templates">
                <div className="grid grid-cols-1 lg:grid-cols-2 gap-x-6 gap-y-6">
                    <div>
                        <label htmlFor="otpWhatsappTemplate" className="block text-sm font-medium text-gray-700 dark:text-gray-300">Customer Login OTP</label>
                        <textarea id="otpWhatsappTemplate" name="otp.whatsappTemplate" value={otpSettings?.whatsappTemplate || ''} onChange={handleInputChange} rows={4} className={textAreaClasses} />
                        <Placeholders keys={['otpCode']} />
                    </div>
                    <div>
                        <label htmlFor="invoiceCreated" className="block text-sm font-medium text-gray-700 dark:text-gray-300">Invoice Created</label>
                        <textarea id="invoiceCreated" name="whatsapp.invoiceCreated" value={whatsappSettings?.invoiceCreated || ''} onChange={handleInputChange} rows={4} className={textAreaClasses} />
                        <Placeholders keys={['customerName', 'customerId', 'invoiceId', 'amount', 'dueDate', 'paymentLink', 'packageName', 'billingPeriod']} />
                    </div>
                    <div>
                        <label htmlFor="invoiceReminder" className="block text-sm font-medium text-gray-700 dark:text-gray-300">Due Date Reminder (H-1)</label>
                        <textarea id="invoiceReminder" name="whatsapp.invoiceReminder" value={whatsappSettings?.invoiceReminder || ''} onChange={handleInputChange} rows={4} className={textAreaClasses} />
                        <Placeholders keys={['customerName', 'customerId', 'invoiceId', 'amount', 'paymentLink', 'packageName', 'billingPeriod', 'dueDate']} />
                    </div>
                    <div>
                        <label htmlFor="paymentSuccess" className="block text-sm font-medium text-gray-700 dark:text-gray-300">Payment Success</label>
                        <textarea id="paymentSuccess" name="whatsapp.paymentSuccess" value={whatsappSettings?.paymentSuccess || ''} onChange={handleInputChange} rows={4} className={textAreaClasses} />
                        <Placeholders keys={['customerName', 'customerId', 'invoiceId', 'amount', 'packageName', 'billingPeriod', 'paymentMethod']} />
                    </div>
                    <div>
                        <label htmlFor="affiliateTopupSuccess" className="block text-sm font-medium text-gray-700 dark:text-gray-300">Affiliate Top-Up Success</label>
                        <textarea id="affiliateTopupSuccess" name="whatsapp.affiliateTopupSuccess" value={whatsappSettings?.affiliateTopupSuccess || ''} onChange={handleInputChange} rows={4} className={textAreaClasses} />
                        <Placeholders keys={['customerName', 'amount', 'newBalance']} />
                    </div>
                    <div>
                        <label htmlFor="suspensionWarning" className="block text-sm font-medium text-gray-700 dark:text-gray-300">Suspension Warning</label>
                        <textarea id="suspensionWarning" name="whatsapp.suspensionWarning" value={whatsappSettings?.suspensionWarning || ''} onChange={handleInputChange} rows={4} className={textAreaClasses} />
                        <Placeholders keys={['customerName', 'customerId', 'invoiceId', 'amount', 'dueDate', 'packageName', 'billingPeriod']} />
                    </div>

                    {/* New templates for suspension and re-activation */}
                     <div>
                        <label htmlFor="accountSuspended" className="block text-sm font-medium text-gray-700 dark:text-gray-300">Account Suspended</label>
                        <textarea id="accountSuspended" name="whatsapp.accountSuspended" value={whatsappSettings?.accountSuspended || ''} onChange={handleInputChange} rows={4} className={textAreaClasses} />
                        <Placeholders keys={['customerName', 'customerId', 'packageName', 'billingPeriod']} />
                    </div>
                     <div>
                        <label htmlFor="accountReactivated" className="block text-sm font-medium text-gray-700 dark:text-gray-300">Account Re-activated</label>
                        <textarea id="accountReactivated" name="whatsapp.accountReactivated" value={whatsappSettings?.accountReactivated || ''} onChange={handleInputChange} rows={4} className={textAreaClasses} />
                        <Placeholders keys={['customerName', 'customerId', 'packageName', 'billingPeriod']} />
                    </div>
                     <div>
                        <label htmlFor="accountDeactivated" className="block text-sm font-medium text-gray-700 dark:text-gray-300">Account Deactivated (Inactive)</label>
                        <textarea id="accountDeactivated" name="whatsapp.accountDeactivated" value={whatsappSettings?.accountDeactivated || ''} onChange={handleInputChange} rows={4} className={textAreaClasses} />
                        <Placeholders keys={['customerName', 'customerId']} />
                    </div>
                    <div>
                        <label htmlFor="resellerBalanceAdded" className="block text-sm font-medium text-gray-700 dark:text-gray-300">Reseller Balance Added</label>
                        <textarea id="resellerBalanceAdded" name="whatsapp.resellerBalanceAdded" value={whatsappSettings?.resellerBalanceAdded || ''} onChange={handleInputChange} rows={4} className={textAreaClasses} />
                        <Placeholders keys={['amountAdded', 'newBalance']} />
                    </div>
                    <div>
                        <label htmlFor="technicianTaskAssignment" className="block text-sm font-medium text-gray-700 dark:text-gray-300">Technician Task Assignment</label>
                        <textarea id="technicianTaskAssignment" name="whatsapp.technicianTaskAssignment" value={whatsappSettings?.technicianTaskAssignment || ''} onChange={handleInputChange} rows={4} className={textAreaClasses} />
                        <Placeholders keys={['technicianName', 'ticketId', 'customerName', 'customerAddress', 'complaintType', 'complaintDescription']} />
                    </div>
                     <div>
                        <label htmlFor="packageChanged" className="block text-sm font-medium text-gray-700 dark:text-gray-300">Package Changed Successfully</label>
                        <textarea id="packageChanged" name="whatsapp.packageChanged" value={whatsappSettings?.packageChanged || ''} onChange={handleInputChange} rows={4} className={textAreaClasses} />
                        <Placeholders keys={['customerName', 'newPackageName']} />
                    </div>
                    <div className="lg:col-span-2 border-t dark:border-gray-700 pt-4">
                         <h4 className="text-md font-medium text-gray-800 dark:text-gray-200 mb-2">Broadcast Templates</h4>
                    </div>
                     <div>
                        <label htmlFor="broadcastGeneral" className="block text-sm font-medium text-gray-700 dark:text-gray-300">General Broadcast Template</label>
                        <textarea id="broadcastGeneral" name="whatsapp.broadcastGeneral" value={whatsappSettings?.broadcastGeneral || ''} onChange={handleInputChange} rows={4} className={textAreaClasses} />
                        <Placeholders keys={['customerName', 'customerId', 'packageName']} />
                    </div>
                    <div>
                        <label htmlFor="broadcastOutage" className="block text-sm font-medium text-gray-700 dark:text-gray-300">Outage Notification Template</label>
                        <textarea id="broadcastOutage" name="whatsapp.broadcastOutage" value={whatsappSettings?.broadcastOutage || ''} onChange={handleInputChange} rows={4} className={textAreaClasses} />
                        <Placeholders keys={['customerName', 'customerId', 'packageName']} />
                    </div>
                    <div>
                        <label htmlFor="broadcastDelayMode" className="block text-sm font-medium text-gray-700 dark:text-gray-300">Broadcast Delay Mode</label>
                        <select
                            id="broadcastDelayMode"
                            name="whatsapp.broadcastDelayMode"
                            value={whatsappSettings?.broadcastDelayMode || 'step'}
                            onChange={handleInputChange}
                            className={`mt-1 block w-full ${inputClasses}`}
                        >
                            <option value="flat">Flat</option>
                            <option value="linear">Linear</option>
                            <option value="step">Step / Batch</option>
                            <option value="randomized">Randomized</option>
                        </select>
                        <p className="mt-2 text-xs text-gray-500 dark:text-gray-400">
                            Flat: delay tetap. Linear: naik tiap pesan. Step: naik per beberapa pesan. Randomized: acak natural.
                        </p>
                    </div>
                    <div>
                        <label htmlFor="broadcastDelayStartMs" className="block text-sm font-medium text-gray-700 dark:text-gray-300">Broadcast Initial Delay (ms)</label>
                        <input
                            type="number"
                            min={0}
                            step={100}
                            id="broadcastDelayStartMs"
                            name="whatsapp.broadcastDelayStartMs"
                            value={whatsappSettings?.broadcastDelayStartMs ?? 1000}
                            onChange={handleInputChange}
                            className={`mt-1 block w-full ${inputClasses}`}
                        />
                        <p className="mt-2 text-xs text-gray-500 dark:text-gray-400">
                            Delay awal setelah pesan pertama terkirim.
                        </p>
                    </div>
                    <div>
                        <label htmlFor="broadcastDelayIncrementMs" className="block text-sm font-medium text-gray-700 dark:text-gray-300">Broadcast Delay Increment (ms)</label>
                        <input
                            type="number"
                            min={0}
                            step={100}
                            id="broadcastDelayIncrementMs"
                            name="whatsapp.broadcastDelayIncrementMs"
                            value={whatsappSettings?.broadcastDelayIncrementMs ?? 750}
                            onChange={handleInputChange}
                            className={`mt-1 block w-full ${inputClasses}`}
                        />
                        <p className="mt-2 text-xs text-gray-500 dark:text-gray-400">
                            Setiap pesan berikutnya akan menambah jeda sebesar nilai ini sampai batas maksimum.
                        </p>
                    </div>
                    <div>
                        <label htmlFor="broadcastDelayStepEvery" className="block text-sm font-medium text-gray-700 dark:text-gray-300">Broadcast Step Every (messages)</label>
                        <input
                            type="number"
                            min={1}
                            step={1}
                            id="broadcastDelayStepEvery"
                            name="whatsapp.broadcastDelayStepEvery"
                            value={whatsappSettings?.broadcastDelayStepEvery ?? 5}
                            onChange={handleInputChange}
                            className={`mt-1 block w-full ${inputClasses}`}
                        />
                        <p className="mt-2 text-xs text-gray-500 dark:text-gray-400">
                            Hanya dipakai untuk mode Step. Contoh 5 berarti delay naik setiap 5 pesan.
                        </p>
                    </div>
                    <div>
                        <label htmlFor="broadcastDelayRandomJitterMs" className="block text-sm font-medium text-gray-700 dark:text-gray-300">Broadcast Random Jitter (ms)</label>
                        <input
                            type="number"
                            min={0}
                            step={100}
                            id="broadcastDelayRandomJitterMs"
                            name="whatsapp.broadcastDelayRandomJitterMs"
                            value={whatsappSettings?.broadcastDelayRandomJitterMs ?? 1500}
                            onChange={handleInputChange}
                            className={`mt-1 block w-full ${inputClasses}`}
                        />
                        <p className="mt-2 text-xs text-gray-500 dark:text-gray-400">
                            Hanya dipakai untuk mode Randomized. Nilai ini menentukan seberapa jauh delay bisa diacak dari delay awal.
                        </p>
                    </div>
                    <div className="lg:col-span-2">
                        <label htmlFor="broadcastDelayMaxMs" className="block text-sm font-medium text-gray-700 dark:text-gray-300">Broadcast Maximum Delay (ms)</label>
                        <input
                            type="number"
                            min={0}
                            step={100}
                            id="broadcastDelayMaxMs"
                            name="whatsapp.broadcastDelayMaxMs"
                            value={whatsappSettings?.broadcastDelayMaxMs ?? 7000}
                            onChange={handleInputChange}
                            className={`mt-1 block w-full max-w-xs ${inputClasses}`}
                        />
                        <p className="mt-2 text-xs text-gray-500 dark:text-gray-400">
                            Delay bertingkat tidak akan melebihi nilai ini.
                        </p>
                    </div>
                    <div className="lg:col-span-2 border-t dark:border-gray-700 pt-4">
                        <label htmlFor="adminPhoneNumber" className="block text-sm font-medium text-gray-700 dark:text-gray-300">Admin/Technician Phone Number</label>
                        <input
                            type="tel"
                            id="adminPhoneNumber"
                            name="whatsapp.adminPhoneNumber"
                            value={whatsappSettings?.adminPhoneNumber || ''}
                            onChange={handleInputChange}
                            className={`mt-1 block w-full max-w-xs ${inputClasses}`}
                            placeholder="e.g., 628123456789"
                        />
                        <p className="mt-2 text-xs text-gray-500 dark:text-gray-400">
                            The number that will receive notifications for new customer complaints. Use country code format.
                        </p>
                    </div>
                    <div>
                        <label htmlFor="newComplaintNotification" className="block text-sm font-medium text-gray-700 dark:text-gray-300">New Complaint Notification (for Admin)</label>
                        <textarea id="newComplaintNotification" name="whatsapp.newComplaintNotification" value={whatsappSettings?.newComplaintNotification || ''} onChange={handleInputChange} rows={4} className={textAreaClasses} />
                        <Placeholders keys={['customerName', 'customerId', 'customerPhone', 'complaintType', 'description', 'packageName']} />
                    </div>
                    <div>
                        <label htmlFor="newRegistrationNotification" className="block text-sm font-medium text-gray-700 dark:text-gray-300">New Registration Notification (for Admin)</label>
                        <textarea id="newRegistrationNotification" name="whatsapp.newRegistrationNotification" value={whatsappSettings?.newRegistrationNotification || ''} onChange={handleInputChange} rows={4} className={textAreaClasses} />
                        <Placeholders keys={['customerName', 'customerId', 'customerPhone', 'customerEmail', 'packageName', 'address']} />
                    </div>
                </div>
            </Card>
        </div>
    );
};

export default WhatsAppSettings;
