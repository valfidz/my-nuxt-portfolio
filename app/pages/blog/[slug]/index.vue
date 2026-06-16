<script setup lang="ts">
import { marked } from 'marked'
import type { ContentTocLink } from '@nuxt/ui'

definePageMeta({
    layout: 'main'
})

const route = useRoute()
const slug = route.params.slug as string

const { data: post } = await useFetch<{
  title: string
  slug: string
  description: string
  date: string
  content: string
  tags: string[]
}>(`/api/blogs/${slug}`)

const formattedDate = computed(() => {
    if (!post.value?.date) return ''
    return new Date(post.value.date).toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    })
})

// Set up custom renderer BEFORE parsedContent so headings get IDs
const renderer = new marked.Renderer()
renderer.heading = ({ text, depth }: { text: string, depth: number }) => {
  const id = text.toLowerCase().replace(/[^\w\s-]/g, '').replace(/\s+/g, '-')
  return `<h${depth} id="${id}">${text}</h${depth}>`
}
marked.use({ renderer })

const parsedContent = computed(() => {
  const content = post.value?.content
  if (!content) return ''
  return marked(content)
})

// Generate TOC links from markdown headings
const tocLinks = computed<ContentTocLink[]>(() => {
  const content = post.value?.content
  if (!content) return []

  const tokens = marked.lexer(content)
  const links: ContentTocLink[] = []

  for (const token of tokens) {
    if (token.type === 'heading') {
      const id = token.text
        .toLowerCase()
        .replace(/[^\w\s-]/g, '')
        .replace(/\s+/g, '-')

      const link: ContentTocLink = {
        id,
        text: token.text,
        depth: token.depth,
      }

      if (token.depth === 2) {
        links.push(link)
      } else if (token.depth === 3) {
        const parent = links[links.length - 1]
        if (parent) {
          if (!parent.children) parent.children = []
          parent.children.push(link)
        }
      }
    }
  }

  return links
})

// Mobile TOC accordion state
const tocOpen = ref(false)
</script>

<template>
  <UPage>
    <UContainer class="mt-10 pb-16">

      <UButton
        icon="i-lucide-arrow-left"
        label="Back to blog"
        color="neutral"
        variant="ghost"
        size="xl"
        to="/blog"
      />

      <!-- Meta row -->
      <div class="mt-6 flex flex-row gap-6">
        <div class="flex flex-row gap-2 items-center">
          <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M8 2v4"/><path d="M16 2v4"/><rect width="18" height="18" x="3" y="4" rx="2"/><path d="M3 10h18"/></svg>
          <p>{{ formattedDate }}</p>
        </div>
      </div>

      <UPageHeader
        :title="post?.title"
        :ui="{ root: 'border-b-0' }"
      />

      <!-- Article content -->
      <div class="prose prose-neutral dark:prose-invert max-w-none mt-8" v-html="parsedContent" />

    </UContainer>

    <!-- Desktop sticky TOC in right slot (shown on lg+) -->
    <template v-if="tocLinks.length" #right>
      <div class="sticky top-[calc(var(--ui-header-height,64px)+2rem)] max-h-[calc(100vh-var(--ui-header-height,64px)-4rem)] overflow-y-auto space-y-2 hidden lg:block">
        <p class="text-sm font-semibold">On this page</p>
        <ul class="space-y-1 border-l border-default">
          <template v-for="link in tocLinks" :key="link.id">
            <li>
              <a
                :href="`#${link.id}`"
                class="block text-sm text-muted hover:text-default transition-colors py-1 pl-4"
              >
                {{ link.text }}
              </a>
            </li>
            <li v-for="child in link.children" :key="child.id">
              <a
                :href="`#${child.id}`"
                class="block text-sm text-muted hover:text-default transition-colors py-1 pl-7"
              >
                {{ child.text }}
              </a>
            </li>
          </template>
        </ul>
      </div>
    </template>

  </UPage>
</template>
