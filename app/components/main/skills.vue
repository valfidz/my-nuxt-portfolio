<script setup lang="ts">
const { data: skills } = await useFetch<{
  id: string
  title: string
  stacks: string[]
}[]>('/api/skills')

const { el } = useStaggerAnimation()
</script>

<template>
  <section id="skills" ref="el" class="stagger-children max-w-5xl mx-auto px-6 pt-24 pb-12">
    <div class="section-label">Skills &amp; Tools</div>
    <h2 class="text-3xl sm:text-4xl font-bold tracking-tight mb-8">
      What I work with
    </h2>

    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
      <div
        v-for="skill in (skills ?? [])"
        :key="skill.id"
        class="card-lift bg-[var(--ui-bg-elevated)] rounded-xl p-6 border border-[var(--ui-border)] hover:border-[var(--ui-primary)]/20"
      >
        <h4 class="text-sm font-semibold text-[var(--ui-primary)] mb-4 uppercase tracking-wide">
          {{ skill.title }}
        </h4>
        <div class="flex flex-wrap gap-2">
          <span
            v-for="stack in skill.stacks"
            :key="stack"
            class="skill-pill"
          >
            {{ stack }}
          </span>
        </div>
      </div>
    </div>
  </section>
</template>
