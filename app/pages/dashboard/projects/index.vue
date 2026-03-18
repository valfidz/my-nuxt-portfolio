<script setup lang="ts">
import type { TableColumn } from '@nuxt/ui'

definePageMeta({
    layout: 'dashboard'
})

type Projects = {
    title: string
    stacks: string[]
    description: string
    link: string
}

const projects = ref<Projects[]> ([
  {
    title: 'Simple World Map',
    stacks: [
      'Bun',
      'Javascript',
      'Svelte',
      'Sveltekit',
      'Supabase',
      'Leaflet'
    ],
    description: 'Simple world map built by svelte and supabase',
    link: 'https://github.com/valfidz/geo-map'
  },
  {
    title: 'Pipopa Landing Page',
    stacks: [
      'Javascript',
      'React.js',
    ],
    description: 'Landing page for Pipopa company profile built by React.js',
    link: 'https://github.com/valfidz/pipopa-fe/tree/production'
  },
  {
    title: 'Pipopa Dashboard',
    stacks: [
      'Javascript',
      'React.js',
    ],
    description: 'Dashboard for Pipopa company profile built by React.js',
    link: 'https://github.com/valfidz/admin-compro-cra-pipopa/tree/production'
  },
  {
    title: 'Pipopa Backend',
    stacks: [
      'Javascript',
      'Node.js',
      'Express.js',
      'MySQL'
    ],
    description: 'Backend API for Pipopa company profile built by Express.js and MySQL',
    link: 'https://github.com/valfidz/pipopa-be/tree/production'
  },
])

const columns: TableColumn<Projects>[] = [
    {
        accessorKey: 'title',
        header: 'Title',
    },
    {
        accessorKey: 'description',
        header: 'Description',
    },
    {
        id: 'action',
        header: 'Actions'
    }
]

</script>

<template>
    <UContainer>
        <UPageHeader
            title="Featured Projects"
            :ui="{
                root: 'border-b-0'
            }"
        >
            <template #links>
                <UButton
                    label="Add Project"
                    color="neutral"
                    size="lg"
                    icon="i-lucide-square-pen"
                    to="/dashboard/projects/add"
                />
            </template>
        </UPageHeader>

        <UCard>
            <UTable
                :data="projects"
                :columns="columns"
                class="flex-1"
            >
                <template #title-cell="{ row }">
                    <p>{{ row.original.title }}</p>
                </template>

                <template #description-cell="{ row }">
                    <p>{{ row.original.description }}</p>
                </template>

                <template #action-cell>
                    <div class="flex flex-row gap-4">
                        <UButton
                            label="Edit"
                            color="neutral"
                            variant="outline"
                            icon="i-lucide-square-pen"
                            size="sm"
                        />
                        <UButton
                            label="Delete"
                            color="error"
                            icon="i-lucide-trash-2"
                            size="sm"
                        />
                    </div>
                </template>
            </UTable>
        </UCard>
    </UContainer>
</template>