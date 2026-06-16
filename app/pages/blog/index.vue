<script setup lang="ts">
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

const formatDate = (dateStr: string) => {
  const d = new Date(dateStr)
  return d.toLocaleDateString('en-US', {
    year: 'numeric', month: 'long', day: 'numeric'
  })
}
</script>

<template>
  <div class="min-h-screen">
    <div class="max-w-3xl mx-auto px-6 pt-32 pb-20">
      <span class="section-label">Blog</span>
      <h1 class="text-3xl sm:text-4xl font-bold tracking-tight mt-2 mb-10">
        All posts
      </h1>

      <div class="space-y-5">
        <NuxtLink
          v-for="post in (posts ?? [])"
          :key="post.id"
          :to="`/blog/${post.slug}`"
          class="card-lift group block p-6 bg-[var(--ui-bg-elevated)] rounded-xl border border-[var(--ui-border)] hover:border-[var(--ui-primary)]/20"
        >
          <div class="flex items-center gap-3 text-xs text-[var(--ui-text-dim)] mb-2">
            <span>{{ formatDate(post.date) }}</span>
          </div>
          <h2 class="font-semibold text-lg group-hover:text-[var(--ui-primary)] transition-colors mb-2">
            {{ post.title }}
          </h2>
          <p class="text-sm text-[var(--ui-text-dim)] leading-relaxed line-clamp-2">
            {{ post.description }}
          </p>
        </NuxtLink>
      </div>
    </div>
  </div>
</template>
