<script setup lang="ts">
import type { NavigationMenuItem } from '@nuxt/ui'

const items: NavigationMenuItem[] = [{
  label: 'Home',
  icon: 'i-lucide-house',
  to: '/dashboard'
}, {
  label: 'About Me',
  icon: 'i-lucide-info',
  to: '/dashboard/about'
}, {
    label: 'Featured Projects',
    icon: 'i-lucide-monitor-cog',
    to: '/dashboard/projects'
}, {
    label: 'Technical Skills',
    icon: 'i-lucide-cpu',
    to: '/dashboard/skills'
}, {
    label: 'Blog',
    icon: 'i-lucide-rss',
    to: '/dashboard/blogs'
}]
</script>

<template>
    <div class="flex h-screen overflow-hidden">
        <UDashboardSidebar collapsible resizable :ui="{ footer: 'border-t border-default' }">
        <template #header="{ collapsed }">
            <UHeader :ui="{ root: 'border-b-0 mx-auto' }">
                <template #title>
                    <h1>VALCODE</h1>
                </template>

                <template #right>
                    <UColorModeButton />
                </template>
            </UHeader>
        </template>

        <template #default="{ collapsed }">
            <UNavigationMenu
            :collapsed="collapsed"
            :items="items"
            orientation="vertical"
            />
        </template>

        <template #footer="{ collapsed }">
            <UButton
                :avatar="{ src: 'https://github.com/benjamincanac.png', loading: 'lazy' as const }"
                :label="collapsed ? undefined : 'Benjamin'"
                color="neutral"
                variant="ghost"
                class="w-full"
                :block="collapsed"
            />
            <UButton
                label="Logout"
                size="sm"
                color="neutral"
            />
        </template>
        </UDashboardSidebar>

        <div class="flex-1 overflow-auto">
        <slot />
        </div>
    </div>
</template>