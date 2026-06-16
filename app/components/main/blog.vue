<script setup lang="ts">
const { data: blogs } = await useFetch<{
  id: string
  title: string
  slug: string
  description: string
  date: string
}[]>('/api/blogs')

const { el } = useStaggerAnimation()

const formatDate = (dateStr: string) => {
  const d = new Date(dateStr)
  return d.toLocaleDateString('en-US', {
    year: 'numeric', month: 'long', day: 'numeric'
  })
}
</script>

<template>
  <section id="blog" ref="el" class="stagger-children max-w-5xl mx-auto px-6 pt-24 pb-12">
    <div class="section-label">Blog</div>
    <h2 class="text-3xl sm:text-4xl font-bold tracking-tight mb-8">
      Latest posts
    </h2>

    <div class="space-y-4">
      <NuxtLink
        v-for="blog in (blogs ?? [])"
        :key="blog.id"
        :to="`/blog/${blog.slug}`"
        class="card-lift group flex flex-col sm:flex-row sm:items-center gap-4 p-5 bg-[var(--ui-bg-elevated)] rounded-xl border border-[var(--ui-border)] hover:border-[var(--ui-primary)]/20"
      >
        <div class="flex-1 min-w-0">
          <h3 class="font-semibold group-hover:text-[var(--ui-primary)] transition-colors truncate">
            {{ blog.title }}
          </h3>
          <p class="text-sm text-[var(--ui-text-dim)] mt-1 line-clamp-2">
            {{ blog.description }}
          </p>
        </div>
        <div class="flex items-center gap-3 shrink-0">
          <span class="text-xs text-[var(--ui-text-dim)]">{{ formatDate(blog.date) }}</span>
          <Icon name="i-lucide-arrow-right" class="w-4 h-4 text-[var(--ui-primary)] transition-transform duration-200 group-hover:translate-x-1" />
        </div>
      </NuxtLink>

      <div class="pt-4">
        <UButton
          color="neutral"
          variant="outline"
          to="/blog"
          trailing-icon="i-lucide-arrow-right"
        >
          View all posts
        </UButton>
      </div>
    </div>
  </section>
</template>
