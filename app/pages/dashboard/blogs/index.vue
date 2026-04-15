<script setup lang="ts">
import type { TableColumn } from '@nuxt/ui'

definePageMeta({
    layout: 'dashboard'
})

type Blogs = {
    title: string
    description: string
    content: string
    slug: string
    status: 'published' | 'draft'
    date: string
}

const toast = useToast()

const posts = ref<Blogs[]>([
  {
    title: 'Building Scalable APIs with Node.js and PostgreSQL',
    slug: 'building-scalable-apis-with-nodejs-and-postgresql',
    description: `Learn best practices for designing and implementing scalable REST APIs using Node.js, Express, and PostgreSQL. We'll cover database design, caching strategies, and performance optimization.`,
    content: 'Lorem ipsum dolor sit amet',
    status: 'published',
    date: '2026-03-11',
  },
])

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
    toast.add({ title: 'Success', description: 'Item deleted successfully', color: 'success' })
    console.log("Deleted post: ", slug)
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
                :data="posts"
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