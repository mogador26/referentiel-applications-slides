import { defineConfig } from 'vite'
import { slidevPlugin } from '@slidev/vite-plugin-slidev'

export default defineConfig({
  plugins: [slidevPlugin()],
  // Ajoutez ici des options de configuration supplémentaires si nécessaire
  server: {
    port: 3030, // Changez le port si nécessaire
    open: true, // Ouvrir automatiquement le navigateur
  },
  build: {
    assetsDir: 'assets_ext',
    outDir: 'dist_ext', // Répertoire de sortie pour les builds
  },
  // Vous pouvez ajouter d'autres configurations comme alias, etc.
})

