<script setup lang="ts">
import type { TableColumn } from '@nuxt/ui'

definePageMeta({
    layout: 'dashboard'
})

type Blogs = {
    id: string
    title: string
    description: string
    slug: string
    status: 'published' | 'draft'
    date: string
}

const { data: posts, refresh } = await useFetch<Blogs[]>('/api/blogs')

const toast = useToast()

const columns: TableColumn<Blogs>[] = [
    {
        accessorKey: 'title',
        header: 'Title'
    },
    {
        accessorKey: 'description',
        header: 'Description',
        meta: {
            class: {
                td: 'whitespace-normal break-words text-justify'
            }
        }
    },
    {
        accessorKey: 'status',
        header: 'Status'
    },
    {
        accessorKey: 'date',
        header: 'Date'
    },
    {
        id: 'action',
        header: 'Action'
    }
]

const capitalize = (word: string) => {
    if (!word) return word
    return word.charAt(0).toUpperCase() + word.slice(1)
}

const toEdit = async (slug: string) => {
    await navigateTo(`/dashboard/blogs/${slug}/edit`)
}

const deleteItem = async (slug: string) => {
  try {
    await $fetch(`/api/blogs/${slug}`, { method: 'DELETE' })
    toast.add({ title: 'Success', description: 'Post deleted successfully', color: 'success' })
    refresh()
  } catch (err: any) {
    toast.add({ title: 'Failed', description: err.message || 'Something went wrong', color: 'error' })
  }
}
</script>

<template>
    <UContainer>
        <UPageHeader
            title="Blogs"
            :ui="{
                root: 'border-b-0'
            }"
        >
            <template #links>
                <UButton
                    label="Add Post"
                    color="neutral"
                    size="lg"
                    icon="i-lucide-square-pen"
                    to="/dashboard/blogs/add"
                />
            </template>
        </UPageHeader>

        <UCard>
            <UTable
                :data="posts ?? []"
                :columns="columns"
                class="flex-1"
            >
                <template #title-cell="{ row }">
                    <p>{{ row.original.title }}</p>
                </template>

                <template #description-cell="{ row }">
                    <p>{{ row.original.description }}</p>
                </template>

                <template #status-cell="{ row }">
                    <UBadge
                        :color="row.original.status === 'published' ? 'info' : 'warning'"
                    >
                        {{ capitalize(row.original.status) }}
                    </UBadge>
                </template>

                <template #date-cell="{ row }">
                    <p>{{ row.original.date }}</p>
                </template>

                <template #action-cell="{ row }">
                    <div class="flex flex-row gap-4">
                        <UButton
                            label="Edit"
                            color="neutral"
                            variant="outline"
                            icon="i-lucide-square-pen"
                            size="sm"
                            @click="toEdit(row.original.slug)"
                        />
                        <UButton
                            label="Delete"
                            color="error"
                            icon="i-lucide-trash-2"
                            size="sm"
                            @click="deleteItem(row.original.slug)"
                        />
                    </div>
                </template>
            </UTable>
        </UCard>
    </UContainer>
</template>
