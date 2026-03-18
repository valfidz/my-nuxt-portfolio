<script setup lang="ts">
import type { TableColumn } from '@nuxt/ui'

definePageMeta({
    layout: 'dashboard'
})

type Skills = {
    title: string
    stacks: string[]
}

const skills = ref<Skills[]>([
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
])

const columns: TableColumn<Skills>[] = [
    {
      accessorKey: 'title',
      header: 'Title'
    },
    {
      accessorKey: 'stacks',
      header: 'Stacks'
    },
    {
      id: 'action',
      header: 'Actions'
    }
]

const formatArray = (item: string[]) => {
  const stack = item.join(', ')

  return stack
}
</script>

<template>
    <UContainer>
        <UPageHeader
            title="Technical Skills"
            :ui="{
                root: 'border-b-0'
            }"
        >
            <template #links>
                <UButton
                    label="Add Skill"
                    color="neutral"
                    size="lg"
                    icon="i-lucide-square-pen"
                    to="/dashboard/skills/add"
                />
            </template>
        </UPageHeader>

        <UCard>
          <UTable
            :data="skills"
            :columns="columns"
            class="flex-1"
          >
            <template #title-cell="{ row }">
              <p>{{ row.original.title }}</p>
            </template>

            <template #stacks-cell="{ row }">
              <p>{{ formatArray(row.original.stacks) }}</p>
            </template>

            <template #action-cell>
                <div class="flex flex-row gap-4">
                    <UButton
                        label="Edit"
                        color="neutral"
                        variant="outline"
                        icon="i-lucide-square-pen"
                        size="sm"
                    />
                    <UButton
                        label="Delete"
                        color="error"
                        icon="i-lucide-trash-2"
                        size="sm"
                    />
                </div>
            </template>
          </UTable>
        </UCard>
    </UContainer>
</template>