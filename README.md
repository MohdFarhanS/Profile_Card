# Flutter Profile App

Aplikasi profil Flutter yang menampilkan berbagai komponen custom dengan animasi yang menarik.

## Fitur Aplikasi

### 1. **Column Widget untuk Layout Vertikal**
- `CustomColumn` - Column dengan animasi fade-in dan slide-up
- Mendukung kustomisasi alignment dan padding
- Animasi otomatis untuk child widgets

### 2. **CircleAvatar untuk Foto Profil**
- `CircleAvatarWidget` - Avatar dengan border gradient dan shadow
- Animasi scale dan rotation saat load
- Support untuk network image dan placeholder

### 3. **Text Widget untuk Nama dan Deskripsi**
- `CustomTextWidget` - Text dengan berbagai style (heading, body, caption)
- Gradient text untuk heading
- Animasi fade-in dengan slide effect

### 4. **Row untuk Ikon Media Sosial**
- `SocialMediaRow` - Row dengan ikon media sosial interaktif
- Hover effects dan animasi scale
- Integrasi dengan Font Awesome icons

### 5. **BoxDecoration dan TextStyle**
- `StyledContainer` - Container dengan gradient, shadow, dan border radius
- Hover effects dan transform animations
- Custom styling yang konsisten

## Komponen Tambahan

- **Stats Cards** - Kartu statistik dengan ikon dan animasi
- **Skills Section** - Bagian keahlian dengan chip tags
- **Animated Background** - Background dengan gradient yang berubah
- **Responsive Design** - Layout yang responsif untuk berbagai ukuran layar

## Struktur Kode

### Models
- `UserModel` - Model data untuk user dan social media

### Widgets
- `CustomColumn` - Column dengan animasi
- `CircleAvatarWidget` - Avatar dengan effects
- `CustomTextWidget` - Text dengan berbagai style
- `SocialMediaRow` - Row untuk social media icons
- `StyledContainer` - Container dengan styling advanced

### Screens
- `ProfileScreen` - Layar utama profil

### Utils & Constants
- `AppColors` - Konstanta warna dan gradient
- `AppConstants` - Konstanta ukuran dan durasi

## Cara Menjalankan

1. Clone atau copy semua file ke project Flutter
2. Run aplikasi dengan `flutter run`

## Kustomisasi

### Mengubah Data Profil
Edit method `_sampleUser` di `ProfileScreen`:

```dart
UserModel get _sampleUser => UserModel(
  name: "Nama Anda",
  description: "Deskripsi Anda",
  profileImage: "URL_FOTO_ANDA",
  socialMediaList: [
    // Tambah/edit social media
  ],
);
```

### Mengubah Warna Theme
Edit `AppColors` di `utils/app_colors.dart`:

```dart
static const Color primaryColor = Color(0xFF6C63FF); // Warna utama
static const Color secondaryColor = Color(0xFF50C2C9); // Warna sekunder
```

### Menambah Animasi
Semua widget mendukung parameter `isAnimated` untuk mengaktifkan/nonaktifkan animasi.

## Fitur Animasi

- **Fade In Animation** - Semua elemen muncul dengan smooth fade
- **Scale Animation** - Avatar dan container dengan effect scale
- **Slide Animation** - Text dan elemen slide dari bawah
- **Hover Effects** - Social media icons dan containers
- **Background Animation** - Gradient background yang berubah
- **Stagger Animation** - Elemen muncul berurutan

## Performance Tips

- Semua animasi menggunakan `SingleTickerProviderStateMixin`
- Proper disposal untuk animation controllers
- Optimized build methods dengan `AnimatedBuilder`
- Conditional animations untuk better performance