<script setup lang="ts">
const blogs = [
  {
    title: 'Building Scalable APIs with Node.js and PostgreSQL',
    information: 'March 15, 2025 • 8 min read',
    description: `Learn best practices for designing and implementing scalable REST APIs using Node.js, Express, and PostgreSQL. We'll cover database design, caching strategies, and performance optimization.`
  }
]
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
        v-for="blog in blogs"
        :title="blog.title"
        :information="blog.information"
        :description="blog.description"
      />
    </div>
  </div>
</template>