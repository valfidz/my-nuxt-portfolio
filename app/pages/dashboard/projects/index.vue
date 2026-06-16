<script setup lang="ts">
import type { TableColumn } from '@nuxt/ui'

definePageMeta({
    layout: 'dashboard'
})

type Projects = {
    id: string,
    title: string
    stacks: string[]
    description: string
    link: string
}

const { data: projects, refresh } = await useFetch<Projects[]>('/api/projects')

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

const toEdit = async (id: string) => {
    await navigateTo(`/dashboard/projects/${id}/edit`)
}

const toast = useToast()

const deleteItem = async (id: string) => {
  try {
    const { error } = await $fetch(`/api/projects/${id}`, { method: 'DELETE' })
    if (error) throw new Error(error)
    toast.add({ title: 'Success', description: 'Item deleted successfully', color: 'success' })
    refresh()
  } catch (err: any) {
    toast.add({ title: 'Failed', description: err.message || 'Something went wrong', color: 'error' })
  }
}

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
                :data="projects ?? []"
                :columns="columns"
                class="flex-1"
            >
                <template #title-cell="{ row }">
                    <p>{{ row.original.title }}</p>
                </template>

                <template #description-cell="{ row }">
                    <p>{{ row.original.description }}</p>
                </template>

                <template #action-cell="{ row }">
                    <div class="flex flex-row gap-4">
                        <UButton
                            label="Edit"
                            color="neutral"
                            variant="outline"
                            icon="i-lucide-square-pen"
                            size="sm"
                            @click="toEdit(row.original.id)"
                        />
                        <UButton
                            label="Delete"
                            color="error"
                            icon="i-lucide-trash-2"
                            size="sm"
                            @click="deleteItem(row.original.id)"
                        />
                    </div>
                </template>
            </UTable>
        </UCard>
    </UContainer>
</template>
