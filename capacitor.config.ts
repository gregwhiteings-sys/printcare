import type { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.millennium.printcare',
  appName: 'Millennium PrintCare',
  webDir: 'www',
  server: {
    // This keeps the app connected to the live shared database and office dashboard.
    // Set PRINTCARE_URL in the build shell to change the hosted app address.
    url: process.env.PRINTCARE_URL || 'https://millennium-printcare-service-desk.astute-loom-2153.chatgpt.site',
    cleartext: false,
    allowNavigation: ['millennium-printcare-service-desk.astute-loom-2153.chatgpt.site'],
  },
};

export default config;
