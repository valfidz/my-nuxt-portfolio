<script setup lang="ts">
const { data: projects } = await useFetch<{
  id: string
  title: string
  stacks: string[]
  description: string
  link: string
}[]>('/api/projects')

const { el } = useStaggerAnimation()

const thumbEmojis = ['🗺️', '🏠', '📊', '⚙️']
</script>

<template>
  <section id="projects" ref="el" class="stagger-children max-w-5xl mx-auto px-6 pt-24 pb-12">
    <div class="section-label">Projects</div>
    <h2 class="text-3xl sm:text-4xl font-bold tracking-tight mb-8">
      Featured work
    </h2>

    <div class="grid grid-cols-1 sm:grid-cols-2 gap-5">
      <NuxtLink
        v-for="(project, i) in (projects ?? [])"
        :key="project.id"
        :to="project.link"
        target="_blank"
        class="card-lift group bg-[var(--ui-bg-elevated)] rounded-xl overflow-hidden border border-[var(--ui-border)] hover:border-[var(--ui-primary)]/20 hover:shadow-xl hover:shadow-black/20"
      >
        <!-- Thumb -->
        <div :class="['project-thumb', `t${i % 6}`]">
          {{ thumbEmojis[i % thumbEmojis.length] }}
        </div>

        <!-- Body -->
        <div class="p-5">
          <h3 class="font-semibold text-lg mb-1 group-hover:text-[var(--ui-primary)] transition-colors">
            {{ project.title }}
          </h3>
          <div class="flex flex-wrap gap-1.5 mb-3">
            <span
              v-for="stack in project.stacks.slice(0, 4)"
              :key="stack"
              class="text-xs px-2 py-0.5 rounded bg-[var(--ui-bg)] text-[var(--ui-text-dim)]"
            >
              {{ stack }}
            </span>
            <span v-if="project.stacks.length > 4" class="text-xs px-2 py-0.5 rounded bg-[var(--ui-bg)] text-[var(--ui-text-dim)]">
              +{{ project.stacks.length - 4 }}
            </span>
          </div>
          <p class="text-sm text-[var(--ui-text-dim)] leading-relaxed line-clamp-2">
            {{ project.description }}
          </p>
        </div>
      </NuxtLink>
    </div>
  </section>
</template>
