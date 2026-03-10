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
    <slot/>
  <UFooter class="mt-10">
    <template #left>
      <p class="text-muted text-sm">Copyright © {{ new Date().getFullYear() }}</p>
    </template>

    <template #right>
      <UButton
        icon="i-simple-icons-discord"
        color="neutral"
        variant="ghost"
        to="https://discord.com/noparufizu"
        target="_blank"
        aria-label="Discord"
      />
      <UButton
        icon="i-simple-icons-x"
        color="neutral"
        variant="ghost"
        to="https://x.com/valfidz"
        target="_blank"
        aria-label="X"
      />
      <UButton
        icon="i-simple-icons-github"
        color="neutral"
        variant="ghost"
        to="https://github.com/valfidz"
        target="_blank"
        aria-label="GitHub"
      />
    </template>
  </UFooter>
</template>
