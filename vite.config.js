import { defineConfig } from 'vite';

export default defineConfig({
  root: 'vite',  // Set your subdirectory as the root
  server: {
    port: 8080,  // Change the port to 80
  },
  build: {
    outDir: '../dist',  // Specify the output directory relative to the project root
  },
});
