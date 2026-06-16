<script setup lang="ts">
import * as z from 'zod'
import type { FormSubmitEvent } from '@nuxt/ui'

const supabase = useSupabaseClient()

const schema = z.object({
  fullName: z.string(),
  email: z.email('Invalid email'),
  password: z.string('Password is required').min(8, 'Must be at least 8 characters'),
  confirmPassword: z.string('Password is required').min(8, 'Must be at least 8 characters'),
  role: z.enum(["Endmin", "Endfielder"])
})

type Schema = z.output<typeof schema>

const state = reactive<Partial<Schema>>({
  fullName: undefined,
  email: undefined,
  password: undefined,
  confirmPassword: undefined,
  role: undefined
})

const loading = ref(false)
// const email = ref('')
// const password = ref('')

const toast = useToast()
const roleItems = ['Endmin', 'Endfielder']

const passwordsMatch = computed(
  () => !state.confirmPassword || state.password === state.confirmPassword
)

const handleSignUp = async (event: FormSubmitEvent<Schema>) => {
  if (state.password !== state.confirmPassword) {
    toast.add({ title: 'Failed', description: 'Password does not match', color: 'error' })
    return
  }

  try {
    loading.value = true
    const { data, error: signUpError } = await supabase.auth.signUp({
        email: event.data.email,
        password: event.data.password,
        options: {
            emailRedirectTo: 'http://localhost:3000/dashboard',
            data: {
              full_name: state.fullName,
              role: state.role
            }
        }
    })

    if (signUpError) throw signUpError

    if (data.user) {
      const { error: profileError } = await supabase
        .from('user_profile')
        .upsert({
          id: data.user.id,
          full_name: state.fullName,
          role: state.role,
          email: state.email,
        })
      if (profileError) console.warn('Profile upsert failed:', profileError.message)
    }

    toast.add({ title: 'Success', description: 'The form has been submitted.', color: 'success' })

    await navigateTo('/dashboard')
  } catch (error) {
    const message = error instanceof Error ? error.message : 'Something went wrong'

    toast.add({ title: 'Failed', description: message, color: 'error' })
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <UForm :schema="schema" :state="state" class="space-y-4" @submit="handleSignUp">
    <UFormField label="Full name" name="fullName">
      <UInput v-model="state.fullName" />
    </UFormField>

    <UFormField label="Email" name="email">
      <UInput v-model="state.email" />
    </UFormField>

    <UFormField label="Password" name="password">
      <UInput v-model="state.password" type="password" />
    </UFormField>

    <UFormField label="Confirm password" name="confirmPassword">
      <UInput v-model="state.confirmPassword" type="password" />
    </UFormField>

    <UFormField class="w-full" label="Role" name="role">
      <USelect class="w-xs" v-model="state.role" :items="roleItems" placeholder="Choose role..." />
    </UFormField>

    <UButton type="submit" :loading="loading">
      Submit
    </UButton>
  </UForm>
</template>
