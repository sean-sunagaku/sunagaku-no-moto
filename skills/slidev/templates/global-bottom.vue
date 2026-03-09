<template>
  <footer v-if="$slidev.nav.currentPage > 1" style="position: fixed; bottom: 8px; right: 16px; font-size: 0.75rem; color: #94a3b8; z-index: 100;">
    {{ $slidev.nav.currentPage }} / {{ $slidev.nav.total }}
  </footer>
</template>
