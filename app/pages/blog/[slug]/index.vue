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

const tocOpen = ref(false)
</script>

<template>
  <UPage>
    <UContainer class="mt-10 pb-16 animate-fade-in-up">

      <UButton
        icon="i-lucide-arrow-left"
        label="Back to blog"
        color="neutral"
        variant="ghost"
        size="xl"
        to="/blog"
      />

      <div v-if="post">
        <!-- Meta row -->
        <div class="mt-6 flex flex-row gap-6 items-center">
          <div class="flex flex-row gap-2 items-center">
            <Icon name="i-lucide-calendar" class="text-muted" />
            <p class="text-muted text-sm">{{ formattedDate }}</p>
          </div>
        </div>

        <UPageHeader
          :title="post.title"
          :description="post.description"
          :ui="{ root: 'border-b-0' }"
        />

        <!-- Mobile TOC accordion -->
        <div v-if="tocLinks.length" class="lg:hidden mt-6 border border-default rounded-lg overflow-hidden">
          <button
            class="w-full flex items-center justify-between px-4 py-3 text-sm font-semibold bg-muted/40 hover:bg-muted/70 transition-colors"
            @click="tocOpen = !tocOpen"
          >
            <span>On this page</span>
            <Icon
              name="i-lucide-chevron-down"
              :class="['transition-transform duration-200', tocOpen ? 'rotate-180' : '']"
            />
          </button>
          <div v-if="tocOpen" class="px-4 py-3 border-t border-default">
            <ul class="space-y-1 border-l border-default">
              <template v-for="link in tocLinks" :key="link.id">
                <li>
                  <a
                    :href="`#${link.id}`"
                    class="block text-sm text-muted hover:text-default transition-colors py-1 pl-4"
                    @click="tocOpen = false"
                  >
                    {{ link.text }}
                  </a>
                </li>
                <li v-for="child in link.children" :key="child.id">
                  <a
                    :href="`#${child.id}`"
                    class="block text-sm text-muted hover:text-default transition-colors py-1 pl-7"
                    @click="tocOpen = false"
                  >
                    {{ child.text }}
                  </a>
                </li>
              </template>
            </ul>
          </div>
        </div>

        <!-- Article content -->
        <div class="prose prose-neutral dark:prose-invert max-w-none mt-8" v-html="parsedContent" />
      </div>

      <div v-else class="flex justify-center mt-20">
        <p class="text-muted animate-pulse-soft">Loading post...</p>
      </div>
    </UContainer>

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
