import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  base: "/", // must same as "import.meta.env.VITE_APP_BASE_PATH" (in the define section below)
  build: {
    outDir: "../backend/public",
    assetsDir: undefined,
  },
  define: {
    'import.meta.env.VITE_APP_BASE_PATH': JSON.stringify("/"), // must same as "base" (configuration above)
  },
})
