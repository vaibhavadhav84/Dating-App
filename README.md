# DateA — Premium Dating App 

A production-grade Flutter dating/social application built with clean architecture, BLoC state management, and live API data from [randomuser.me](https://randomuser.me/api).

## Screenshots

| Home | Explore | Messages | Notifications | Profile |
|------|---------|----------|---------------|---------|
| Swipe Cards | Search & Filter | Stories + Chats | Grouped Timeline | Hero Image |

## Tech Stack

| Category | Package |
|----------|---------|
| State Management | flutter_bloc ^8.x + equatable |
| Navigation | go_router ^13.x |
| HTTP | dio ^5.x |
| Images | cached_network_image ^3.x |
| Fonts | google_fonts (Poppins) |
| UI Scaling | flutter_screenutil ^5.x |
| Shimmer | shimmer ^3.x |
| Pull Refresh | pull_to_refresh ^2.x |
| DI | get_it ^7.x |

## Architecture

```
lib/
├── core/           # Theme, Colors, Router, Dio, DI, Errors
├── features/
│   ├── home/       # Swipe cards, BLoC, API
│   ├── explore/    # Search, Filter, Grid
│   ├── messages/   # Stories, Chat list
│   ├── notifications/ # Grouped timeline
│   ├── profile/    # User detail, Hero animations
│   ├── date_planning/ # Venue tabs
│   └── compliment/ # Bottom sheet modal
└── shared/         # Buttons, Avatar, Skeleton, Nav Bar
```

## Screens

1. **Home/Discover** — Draggable swipe card stack with LIKE/NOPE overlay, spring snap-back, Hero animation
2. **Explore** — Search bar, filter chips, nearby horizontal list, 2-col trending grid
3. **Messages** — Story row with gradient rings, chat list with unread badges
4. **Notifications** — Today/Yesterday/This Week groups, accept/decline actions, animated read state
5. **Profile/UserDetail** — Hero image header, expandable bio, lifestyle grid, sticky CTA bar
6. **Date Planning** — 4-tab (Restaurants/Activities/Coffee/Movies) venue recommendations
7. **Compliment Modal** — Bottom sheet with animated card selection

## Design Tokens

| Token | Value |
|-------|-------|
| Primary | `#FF4D8D` |
| Secondary | `#FCE4EC` |
| Text Primary | `#1A1A1A` |
| Text Secondary | `#777777` |
| Online | `#4CAF50` |
| Card Radius | 28px |

## Getting Started

```bash
flutter pub get
flutter run
```

## API

All user data is fetched from `https://randomuser.me/api/?results=20`. Computed fields (isOnline, isVerified, distance, compatibility, interests, bio) are deterministically seeded from each user's UUID for consistency across sessions.
