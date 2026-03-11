<script setup lang="ts">
import type { BlogPostProps } from '@nuxt/ui'

definePageMeta({
    layout: 'main'
})


const posts = ref<BlogPostProps[]>([
  {
    title: 'Building Scalable APIs with Node.js and PostgreSQL',
    description: `Learn best practices for designing and implementing scalable REST APIs using Node.js, Express, and PostgreSQL. We'll cover database design, caching strategies, and performance optimization.`,
    date: '2026-03-11',
    to: '/blog/building-scalable-apis-with-nodejs-and-postgreqsql'
  },
])
</script>

<template>
    <UPage>
        <UPageHeader
            title="Blog"
            :ui="{
                title: 'mx-auto',
                root: 'border-b-0'
            }"
        />

        <UPageBody>
            <UContainer>
                <UBlogPosts orientation="vertical">
                    <UBlogPost
                        v-for="(post, index) in posts"
                        :key="index"
                        v-bind="post"
                        :to="post.to"
                    />
                </UBlogPosts>
            </UContainer>
        </UPageBody>
    </UPage>
</template>