<script setup lang="ts">
import * as z from 'zod'
import type { FormSubmitEvent } from '@nuxt/ui'

const supabase = useSupabaseClient()
const toast = useToast()

const schema = z.object({
  email: z.email('Invalid email'),
  password: z.string('Password is required').min(1, 'Password is required')
})

type Schema = z.output<typeof schema>

const state = reactive<Partial<Schema>>({
  email: undefined,
  password: undefined
})

const loading = ref(false)

const handleLogin = async (event: FormSubmitEvent<Schema>) => {
  loading.value = true
  try {
    const { error } = await supabase.auth.signInWithPassword({
      email: event.data.email!,
      password: event.data.password!,
    })
    if (error) throw error
    toast.add({ title: 'Success', description: 'Login successful', color: 'success' })
    await navigateTo('/dashboard')
  } catch (error: any) {
    toast.add({ title: 'Failed', description: error.message || 'Something went wrong', color: 'error' })
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <UContainer class="flex justify-center mt-20">
    <UCard class="w-full max-w-md">
      <UPageHeader
        title="Login"
        description="Sign in to your dashboard"
        :ui="{ root: 'border-b-0' }"
      />

      <UForm
        :schema="schema"
        :state="state"
        @submit="handleLogin"
        class="space-y-4 mt-6"
      >
        <UFormField label="Email" name="email">
          <UInput
            v-model="state.email"
            type="email"
            placeholder="your@email.com"
            class="w-full"
          />
        </UFormField>

        <UFormField label="Password" name="password">
          <UInput
            v-model="state.password"
            type="password"
            placeholder="Your password"
            class="w-full"
          />
        </UFormField>

        <UButton type="submit" :loading="loading" class="w-full justify-center" color="neutral" size="lg">
          Sign In
        </UButton>
      </UForm>
    </UCard>
  </UContainer>
</template>
