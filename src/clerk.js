import { Clerk } from '@clerk/clerk-js'

const clerkPubKey = import.meta.env.VITE_CLERK_PUBLISHABLE_KEY

export const clerk = new Clerk(clerkPubKey)
await clerk.load();

const userButton = document.getElementById('user-button');
const user = document.getElementById('user-svg');

userButton.onclick = () => {
    if (!clerk.isSignedIn) {
        clerk.openSignIn()
    }
}

if (clerk.user) {
    user.style.display = 'none';
    clerk.mountUserButton(userButton);
    userButton.style.backgroundColor = 'transparent';
    userButton.style.border = 'none';
} else {
    clerk.openSignIn();
}