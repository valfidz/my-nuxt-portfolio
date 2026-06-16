<script setup lang="ts">
const { data: blogs } = await useFetch<{
  id: string
  title: string
  slug: string
  description: string
  date: string
}[]>('/api/blogs')

const formatDate = (dateStr: string) => {
  const d = new Date(dateStr)
  return d.toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}
</script>

<template>
  <div class="flex flex-col mt-10">
    <UPageHeader
      title="Latest Blog Posts"
      :ui="{
        root: 'border-b-0',
        title: 'mx-auto'
      }"
    />
    <div class="flex flex-col gap-6 items-center">
      <MainBlogCard
        v-for="blog in (blogs ?? [])"
        :key="blog.id"
        :title="blog.title"
        :information="formatDate(blog.date)"
        :description="blog.description"
        :slug="blog.slug"
      />
    </div>
  </div>
</template>
