<script setup lang="ts">
import type { TableColumn } from '@nuxt/ui'

definePageMeta({
    layout: 'dashboard'
})

type Blogs = {
    title: string
    description: string
    status: 'Published' | 'Draft'
    date: string
    to: string
}

const posts = ref<Blogs[]>([
  {
    title: 'Building Scalable APIs with Node.js and PostgreSQL',
    description: `Learn best practices for designing and implementing scalable REST APIs using Node.js, Express, and PostgreSQL. We'll cover database design, caching strategies, and performance optimization.`,
    status: 'Published',
    date: '2026-03-11',
    to: '/blog/building-scalable-apis-with-nodejs-and-postgreqsql'
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
                        :label="row.original.status"
                        :color="row.original.status === 'Published' ? 'info' : 'warning'"
                    />
                </template>

                <template #date-cell="{ row }">
                    <p>{{ row.original.date }}</p>
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