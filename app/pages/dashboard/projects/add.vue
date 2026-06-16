<script setup lang="ts">
import * as z from 'zod'
import type { FormSubmitEvent } from '@nuxt/ui';

definePageMeta({
    layout: 'dashboard'
})

const schema = z.object({
    title: z.string(),
    stacks: z.array(z.string()),
    description: z.string(),
    link: z.string()
})

type Schema = z.output<typeof schema>

const state = reactive<Partial<Schema>>({
    title: undefined,
    stacks: undefined,
    description: undefined,
    link: undefined
})

const toast = useToast()
const loading = ref(false)

const onSubmit = async (event: FormSubmitEvent<Schema>) => {
  loading.value = true
  try {
    await $fetch('/api/projects', {
      method: 'POST',
      body: event.data
    })
    toast.add({ title: 'Success', description: 'Project created successfully', color: 'success' })
    await navigateTo('/dashboard/projects')
  } catch (err: any) {
    toast.add({ title: 'Failed', description: err.message || 'Something went wrong', color: 'error' })
  } finally {
    loading.value = false
  }
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
            to="/dashboard/projects"
        />

        <UPageHeader
            title="Add Projects"
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

                <UFormField label="Description" name="description" :ui="{ label: 'text-2xl font-semibold' }">
                    <UTextarea
                        class="w-full"
                        :rows="12"
                        v-model="state.description"
                    />
                </UFormField>

                <UFormField label="Link" name="link" :ui="{ label: 'text-2xl font-semibold' }">
                    <UInput
                        class="w-full"
                        size="xl"
                        v-model="state.link"
                    />
                </UFormField>

                <UButton
                    type="submit"
                    class="max-w-20 justify-center"
                    color="neutral"
                    size="xl"
                    :loading="loading"
                >
                    Submit
                </UButton>
            </UForm>
        </UCard>
    </UContainer>
</template>
