<script setup lang="ts">
import type { NavigationMenuItem } from '@nuxt/ui'

const route = useRoute()
const { scrolled } = useScrollHeader()

const items = computed<NavigationMenuItem[]>(() => [
  { label: 'About', to: '/#about' },
  { label: 'Skills', to: '/#skills' },
  { label: 'Projects', to: '/#projects' },
  { label: 'Blog', to: '/blog', target: '_blank' },
  { label: 'Contact', to: '/#contact' },
])
</script>

<template>
  <div class="min-h-screen flex flex-col">
    <!-- Fixed header with blur -->
    <nav
      :class="[
        'fixed top-0 left-0 right-0 z-50 flex items-center justify-between px-6 py-3 transition-all duration-300',
        scrolled ? 'header-blur border-b border-[var(--ui-border)]' : 'bg-transparent'
      ]"
    >
      <span class="gradient-text font-bold text-xl tracking-tight">
        <NuxtLink to="/">
          VALCODE
        </NuxtLink>
      </span>

      <ul class="hidden md:flex items-center gap-8 list-none">
        <li v-for="item in items" :key="item.label">
          <NuxtLink
            :to="item.to"
            :target="item.target"
            class="text-sm font-medium text-[var(--ui-text-dim)] hover:text-[var(--ui-text)] transition-colors relative after:content-[''] after:absolute after:left-0 after:-bottom-1 after:w-0 after:h-0.5 after:bg-[var(--ui-primary)] after:transition-all after:duration-300 hover:after:w-full"
          >
            {{ item.label }}
          </NuxtLink>
        </li>
      </ul>

      <div class="flex items-center gap-2">
        <UColorModeButton />
        <UTooltip text="GitHub" :kbds="['meta', 'G']">
          <UButton
            color="neutral"
            variant="ghost"
            icon="i-simple-icons-github"
            to="https://github.com/valfidz"
            target="_blank"
            aria-label="GitHub"
          />
        </UTooltip>
      </div>
    </nav>

    <main class="flex-1">
      <slot />
    </main>

    <footer class="text-center py-6 border-t border-[var(--ui-border)]">
      <p class="text-xs text-[var(--ui-text-dim)]">
        Copyright © {{ new Date().getFullYear() }} VALCODE
      </p>
    </footer>
  </div>
</template>
