<script setup lang="ts">
import type { NavigationMenuItem } from '@nuxt/ui'

const supabase = useSupabaseClient()
const user = useSupabaseUser()

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

const signOut = async () => {
    const { error } = await supabase.auth.signOut()
    if (error) {
      alert(error.message)
      return
    }

    alert('Sign Out Success!')
    navigateTo('/')
}
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
                :avatar="{
                  src: user?.user_metadata?.avatar_url || `https://api.dicebear.com/9.x/initials/svg?seed=${user?.email || 'User'}`,
                  loading: 'lazy' as const
                }"
                :label="collapsed ? undefined : (user?.user_metadata?.full_name || user?.email || 'User')"
                color="neutral"
                variant="ghost"
                class="w-full"
                :block="collapsed"
            />
            <UButton
                label="Logout"
                size="sm"
                color="neutral"
                @click="signOut"
            />
        </template>
        </UDashboardSidebar>

        <div class="flex-1 overflow-auto">
        <slot />
        </div>
    </div>
</template>
