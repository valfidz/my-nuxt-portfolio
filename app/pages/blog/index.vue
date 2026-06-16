<script setup lang="ts">
import type { BlogPostProps } from '@nuxt/ui'

definePageMeta({
    layout: 'main'
})

const { data: posts } = await useFetch<{
  id: string
  title: string
  slug: string
  description: string
  date: string
}[]>('/api/blogs')

const blogPosts = computed<BlogPostProps[]>(() => {
  return (posts.value ?? []).map(p => ({
    title: p.title,
    description: p.description,
    date: p.date,
    to: `/blog/${p.slug}`
  }))
})
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
                        v-for="(post, index) in blogPosts"
                        :key="index"
                        v-bind="post"
                        :to="post.to"
                    />
                </UBlogPosts>
            </UContainer>
        </UPageBody>
    </UPage>
</template>
