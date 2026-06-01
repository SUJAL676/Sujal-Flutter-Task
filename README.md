## Technologies & Packages Used

### Backend & Data Storage

#### Firebase Realtime Database

Used for storing and retrieving reel metadata such as:

* Reel ID
* Username
* Caption
* Likes count
* Video URL

Why?

* Real-time data updates
* Simple integration with Flutter
* Fast read operations for feed data

---

#### Supabase Storage

Used for storing reel video files.

Why?

* Cost-effective media storage
* Easy public URL generation
* Suitable for video content delivery

---

## State Management

### Provider

Used for:

* Reel feed state management
* Like state management
* Bookmark state management
* Loading state handling

Why?

* Lightweight
* Easy to maintain
* Suitable for medium-sized applications

Package:

```yaml
provider
```

---

## Video Playback

### cached_video_player_plus

Used for:

* Video playback
* Video caching
* Reduced network requests
* Faster loading experience

Package:

```yaml
cached_video_player_plus
```

---

### video_player

Used internally for:

* Video rendering
* Play/Pause controls
* Video controller management

Package:

```yaml
video_player
```

---

## Local Storage

### SharedPreferences

Used for:

* Saving liked reels locally
* Saving bookmarked reels locally

Features:

* Persistent user preferences
* Offline support

Package:

```yaml
shared_preferences
```

---

## UI & Animations

### Flutter Animation Framework

Used for:

* Custom splash/loading animation
* Bouncing orb animation
* Full-screen reveal animation
* Caption expansion animation
* Interactive UI transitions

Components:

* AnimationController
* AnimatedBuilder
* AnimatedSwitcher
* AnimatedSize
* Transform

---

## Performance Optimizations

### Custom Video Controller Manager

Implemented to:

* Reuse video controllers
* Reduce memory consumption
* Automatically dispose unused controllers

---

### Video Preload Service

Implemented to:

* Preload upcoming reels
* Reduce playback delay
* Improve scrolling experience

---

## Project Highlights

### Custom Aurora Loading Experience

Features:

* Aurora-inspired gradient background
* Animated bouncing orb
* Rotating micro-messages
* Full-screen reveal transition

---

### Reel Experience

Features:

* Auto-play videos
* Auto-pause previous videos
* Smooth vertical scrolling
* Expandable captions
* Like functionality
* Bookmark functionality

---

## Dependencies

```yaml
firebase_core:
firebase_database:
provider:
shared_preferences:
cached_video_player_plus:
video_player:
google_fonts:
```
