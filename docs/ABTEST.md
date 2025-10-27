1. A/B Test Name: Start on InitialScreen vs Create Account (Nathan)
User Story Number: US1 Account Creation
Metrics:
- Adoption: signup conversion rate = CompleteSignUp / FirstAppOpen
- Engagement: time to first value = time from first open to FirstDrinkLogged
- Task success: funnel completion rate InitialOpen -> ScreenView -> StartSignup -> CompleteSignUp
- Retention guardrail: 1 day return rate for new users
- Happiness proxy guardrail: uninstall within 24h, and taps on Back or Close on signup screen per session
- Quality guardrail: crash free sessions, ANR rate
Hypothesis: 
- Starting the app on Create Account will raise signup conversion by at least 10 percent vs starting on the InitialScreen, by removing one step to account creation, without hurting 1 day retention or increasing early uninstalls. 
- Counter risk: pushing users into Create Account first may feel pushy, increasing exits. The test will decide.
Experiment:
Target audience: only users who are not authenticated on app open. Exclude anyone who ever completed signup on this device or restores a session.
- Split: 50 or 50 using Firebase A or B Testing with Remote Config key start_screen.
Duration and power: run until each variant has at least x new users and the primary metric reaches 95 percent confidence, minimum 7 days to cover weekday and weekend behavior.
Events to track in Firebase Analytics:
- app_first_open
- screen_view with screen_name InitialScreen, CreateAccount
- tap_signup_cta, tap_login_link, tap_back_from_signup
- start_signup, complete_signup
- onboarding_complete
- first_drink_logged
- uninstall_event proxy via daily active dropoff, or use store analytics if available
- crash and ANR are collected by Crashlytics
Funnels and params:
- open -> screen_view -> tap_signup_cta or auto_on_signup -> start_signup -> complete_signup
- record time_to_signup and time_to_first_drink as seconds from app_first_open
Success criteria:
- Primary: variant improves signup conversion by >= 10 percent relative with p < 0.05.
- Must not worsen 1 day retention, crash free sessions, or uninstall proxy by more than 2 percent absolute.
- Rollout plan: if B wins and guardrails hold, set Remote Config default to Create Account for new users. If negative guardrails trigger, prefer InitialScreen.
Variations:
- Variant A: InitialScreen default
- Variant B: Create Account default

- User Story Number: US2 – Hydration Notifications (ADRIAN)

Metrics:

Engagement: average number of daily reminder interactions (notification_open / reminder_sent)

Retention: 7-day return rate for new users (user_retained_7d)

Task Success: drinks logged per user per day (drink_logged)

Happiness proxy guardrail: uninstall within 24 h and notification opt-outs (notif_disabled)

Quality guardrail: crash-free sessions, ANR rate

Hypothesis:
Increasing hydration reminder frequency from every 4 hours to every 2 hours will improve engagement and retention by reminding users more frequently to log drinks, helping them stay on track with hydration goals—without increasing uninstalls or opt-outs.

Counter risk:
Too-frequent notifications may annoy users, causing opt-outs or higher uninstall rates. The test will determine the optimal balance between helpfulness and annoyance.

Experiment:
Target audience: only users who have completed onboarding and enabled notifications. Exclude users who have already opted out or turned off reminders.

Split: 50/50 using Firebase Remote Config with key reminder_interval_hours.

Variant A (control): reminders every 4 hours

Variant B (test): reminders every 2 hours with personalized message (e.g., “Hey Adrian, stay hydrated!”)

Duration and power: run until each variant has at least n new active users and the primary metric reaches 95 percent confidence, minimum 14 days to cover weekday and weekend behavior.

Events to track in Firebase Analytics:
notification_sent
notification_open
drink_logged
user_retained_7d
notif_disabledapp_uninstall
app_crash, anr_occurrence

2. A/B Test Name: Multiple Profile Creation Screens vs One Consolidated Screen of Account Preferences (Kyle Mard)
User Story Number: US1 Account Creation

_Metrics_

Adoption (primary):
signup conversion rate = complete_signup / app_first_open

Engagement:
time to first value = time from app_first_open to first_drink_logged

Task Success:
funnel completion rate = initial_open → screen_view → start_signup → complete_signup

Retention guardrail:
1-day return rate for new users (user_retained_1d)

Happiness proxy guardrail:
uninstalls within 24 h and taps on Back/Close during signup (uninstall_event, tap_back_from_signup)

Quality guardrail:
crash-free sessions, ANR rate

Hypothesis

Consolidating the account creation process into a single screen will improve signup conversion by ≥ 10 % relative to the multi-screen flow by streamlining the experience and reducing friction—without lowering 1-day retention or increasing early uninstalls.

Counter Risk

A single screen may feel cluttered or overwhelming, leading to higher exit or uninstall rates. The experiment will determine which design provides the best balance between simplicity and usability.

Experiment

Target audience:
only unauthenticated users on app open; exclude users who have already completed signup or restored a session.

Split:
50 / 50 using Firebase Remote Config with key signup_screen_mode.

Variant A (control): multi-screen account creation flow
Variant B (test): single consolidated account preferences screen

Duration and power:
run until each variant has at least n new users and the primary metric reaches 95 % confidence, minimum 7 days to cover weekday + weekend behavior.

Events to Track in Firebase Analytics

app_first_open

screen_view (MultiScreenSignup, SingleScreenSignup)

tap_signup_cta, tap_login_link, tap_back_from_signup

start_signup, complete_signup

onboarding_complete, first_drink_logged

uninstall_event (or store analytics proxy)

app_crash, anr_occurrence
