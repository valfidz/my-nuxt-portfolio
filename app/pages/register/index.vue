<script setup lang="ts">
import * as z from 'zod'
import type { FormSubmitEvent } from '@nuxt/ui'

const toast = useToast()

const schema = z.object({
  fullName: z.string().min(1, 'Full name is required'),
  email: z.email('Invalid email'),
  password: z.string('Password is required').min(8, 'Must be at least 8 characters'),
  confirmPassword: z.string('Password is required').min(8, 'Must be at least 8 characters'),
  role: z.enum(['Endmin', 'Endfielder']),
  secret: z.string().min(1, 'Secret key is required')
})

type Schema = z.output<typeof schema>

const state = reactive<Partial<Schema>>({
  fullName: undefined,
  email: undefined,
  password: undefined,
  confirmPassword: undefined,
  role: undefined,
  secret: undefined
})

const loading = ref(false)
const roleItems = ['Endmin', 'Endfielder']

const handleSignUp = async (event: FormSubmitEvent<Schema>) => {
  if (state.password !== state.confirmPassword) {
    toast.add({ title: 'Failed', description: 'Password does not match', color: 'error' })
    return
  }

  loading.value = true
  try {
    const data = await $fetch('/api/register', {
      method: 'POST',
      body: event.data
    })

    toast.add({ title: 'Success', description: 'Registration successful! You can now log in.', color: 'success' })
    await navigateTo('/login')
  } catch (error: any) {
    const message = error.data?.statusMessage || error.message || 'Something went wrong'
    toast.add({ title: 'Failed', description: message, color: 'error' })
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <UContainer class="flex justify-center mt-20 mb-20">
    <UCard class="w-full max-w-md">
      <UPageHeader
        title="Register"
        description="Create a new account"
        :ui="{ root: 'border-b-0' }"
      />

      <UForm :schema="schema" :state="state" class="space-y-4 mt-6" @submit="handleSignUp">
        <UFormField label="Full name" name="fullName">
          <UInput v-model="state.fullName" class="w-full" />
        </UFormField>

        <UFormField label="Email" name="email">
          <UInput v-model="state.email" type="email" class="w-full" />
        </UFormField>

        <UFormField label="Password" name="password">
          <UInput v-model="state.password" type="password" class="w-full" />
        </UFormField>

        <UFormField label="Confirm password" name="confirmPassword">
          <UInput v-model="state.confirmPassword" type="password" class="w-full" />
        </UFormField>

        <UFormField class="w-full" label="Role" name="role">
          <USelect class="w-full" v-model="state.role" :items="roleItems" placeholder="Choose role..." />
        </UFormField>

        <UFormField label="Secret Key" name="secret" :ui="{ label: 'text-sm' }">
          <UInput v-model="state.secret" type="password" class="w-full" placeholder="Registration secret key" />
        </UFormField>

        <UButton type="submit" :loading="loading" class="w-full justify-center" color="neutral" size="lg">
          Register
        </UButton>
      </UForm>
    </UCard>
  </UContainer>
</template>
