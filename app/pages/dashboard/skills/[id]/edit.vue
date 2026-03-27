<script setup lang="ts">
import * as z from 'zod'
import type { FormSubmitEvent } from '@nuxt/ui';

definePageMeta({
    layout: 'dashboard'
})

const route = useRoute()

const skillId = route.params.id ? route.params.id : '0'

const schema = z.object({
    title: z.string(),
    stacks: z.array(z.string())
})

type Skills = {
    id: string,
    title: string
    stacks: string[]
}

type Schema = z.output<typeof schema>

const skills = ref<Skills[]>([
  {
    id: '1',
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
    id: '2',
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
    id: '3',
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
    id: '4',
    title: 'Soft Skills',
    stacks: [
      'Problem Solving',
      'Team Collaboration',
      'Code Review',
      'Agile Development'
    ]
  }
])

const currentSkill = skills.value.filter(skill => skill.id === skillId)

const state = reactive<Partial<Schema>>({
    title: currentSkill[0]?.title,
    stacks: currentSkill[0]?.stacks
})

const toast = useToast()

const onSubmit = async (event: FormSubmitEvent<Schema>) => {
    toast.add({ title: 'Success', description: 'Form has been submitted', color: 'success' })
    console.log(event.data)

    await navigateTo('/dashboard/skills')
}
</script>

<template>
    <UContainer>
        <UButton
            label="Back to Projects"
            icon="i-lucide-arrow-left"
            color="neutral"
            variant="ghost"
            size="lg"
            :ui="{
                base: 'mt-10'
            }"
            to="/dashboard/skills"
        />

        <UPageHeader
            title="Edit Skills"
            :ui="{
                root: 'border-b-0'
            }"
        />

        <UCard class="mb-20">
            <UForm
                :schema="schema"
                :state="state"
                @submit="onSubmit"
                class="flex flex-col gap-8"
            >
                <UFormField label="Title" name="title" :ui="{ label: 'text-2xl font-semibold' }">
                    <UInput
                        class="w-full"
                        size="xl"
                        v-model="state.title"
                    />
                </UFormField>

                <UFormField label="Stacks" name="stacks" :ui="{ label: 'text-2xl font-semibold' }">
                    <UInputTags
                        class="w-full"
                        size="xl"
                        v-model="state.stacks"
                    />
                </UFormField>

                <UButton
                    type="submit"
                    class="max-w-20 justify-center"
                    color="neutral"
                    size="xl"
                >
                    Submit
                </UButton>
            </UForm>
        </UCard>
    </UContainer>
</template>