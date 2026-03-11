<script setup lang="ts">
const projects = [
  {
    title: 'Simple World Map',
    stacks: [
      'Bun',
      'Javascript',
      'Svelte',
      'Sveltekit',
      'Supabase',
      'Leaflet'
    ],
    description: 'Simple world map built by svelte and supabase',
    link: 'https://github.com/valfidz/geo-map'
  },
  {
    title: 'Pipopa Landing Page',
    stacks: [
      'Javascript',
      'React.js',
    ],
    description: 'Landing page for Pipopa company profile built by React.js',
    link: 'https://github.com/valfidz/pipopa-fe/tree/production'
  },
  {
    title: 'Pipopa Dashboard',
    stacks: [
      'Javascript',
      'React.js',
    ],
    description: 'Dashboard for Pipopa company profile built by React.js',
    link: 'https://github.com/valfidz/admin-compro-cra-pipopa/tree/production'
  },
  {
    title: 'Pipopa Backend',
    stacks: [
      'Javascript',
      'Node.js',
      'Express.js',
      'MySQL'
    ],
    description: 'Backend API for Pipopa company profile built by Express.js and MySQL',
    link: 'https://github.com/valfidz/pipopa-be/tree/production'
  },
]
</script>

<template>
  <div id="projects" class="flex flex-col mt-10">
    <UPageHeader
      title="Featured Projects"
      :ui="{
        root: 'border-b-0',
        title: 'mx-auto'
      }"
    />
    <div class="flex flex-wrap justify-center gap-6">
      <MainProjectCard
        v-for="project in projects"
        :title="project.title"
        :stacks="project.stacks"
        :description="project.description"
        :link="project.link"
      />
    </div>
  </div>
</template>