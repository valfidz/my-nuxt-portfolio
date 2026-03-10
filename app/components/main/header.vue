<script setup lang="ts">
import type { NavigationMenuItem } from '@nuxt/ui'

const route = useRoute()

const items = computed<NavigationMenuItem[]>(() => [
  {
    label: 'About',
    to: '#about',
  },
  {
    label: 'Projects',
    to: '#projects',
  },
  {
    label: 'Skills',
    to: '#skills',
  },
  {
    label: 'Blog',
    to: '/blog',
    target: '_blank'
  },
  {
    label: 'Resume',
    to: '#resume',
  },
  {
    label: 'Contact',
    to: '#contact',
  },
])
</script>

<template>
  <UHeader>
    <template #title>
      <h1 class="h-6 text-xl">VALCODE</h1>
    </template>

    <UNavigationMenu :items="items" />

    <template #right>
      <UColorModeButton />

      <UTooltip text="Open on GitHub" :kbds="['meta', 'G']">
        <UButton
          color="neutral"
          variant="ghost"
          to="https://github.com/valfidz"
          target="_blank"
          icon="i-simple-icons-github"
          aria-label="GitHub"
        />
      </UTooltip>
    </template>
  </UHeader>
</template>
