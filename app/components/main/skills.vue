<script setup lang="ts">
const skills = [
  {
    title: 'Backend Development',
    stacks: [
      'Node.js',
      'Express.js',
      'PostgreSQL',
      'Laravel',
      'Redis',
      'Docker',
      'Supabase',
      'Google Cloud Platform'
    ]
  },
  {
    title: 'Frontend Development',
    stacks: [
      'HTML',
      'CSS',
      'Javascript',
      'React.js',
      'Vue.js',
      'Nuxt.js'
    ]
  },
  {
    title: 'Tools & Technologies',
    stacks: [
      'Git',
      'Linux',
      'CI/CD',
      'Microservices',
      'Rest APIs',
      'Testing'
    ]
  },
  {
    title: 'Soft Skills',
    stacks: [
      'Problem Solving',
      'Team Collaboration',
      'Code Review',
      'Agile Development'
    ]
  }
]
</script>

<template>
  <div id="skills" class="flex flex-col mt-10">
    <UPageHeader
      title="Technical Skills"
      :ui="{
        root: 'border-b-0',
        title: 'mx-auto'
      }"
    />
    <div class="flex justify-center">
      <div class="flex flex-wrap gap-6 max-w-2xl">
        <MainSkillCard
          v-for="skill in skills"
          :key="skill.title"
          :title="skill.title"
          :stacks="skill.stacks"
        />
      </div>
    </div>
  </div>
</template>