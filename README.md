# Flutter Theme Showcase

Flutter Material 3 테마 시스템을 최대한 활용한 디자인 시스템 쇼케이스 앱입니다.
라이트 / 다크 / 따뜻한(Warm) / 차가운(Cool) 4가지 테마를 전환하며 컴포넌트 스타일을 확인할 수 있습니다.

---

## 주요 기능

- **4가지 테마** 실시간 전환 (Light / Dark / Warm / Cool)
- **컬러 팔레트** — Primary, Neutral, Semantic, Extended 색상 시각화
- **UI 컴포넌트** — 버튼, 배지, 알림, 입력 필드, 토글
- **팝업** — 기본 확인 / 성공·오류·경고 알림 / 삭제 확인 / 입력 다이얼로그
- **바텀 시트** — 액션 시트 / 결제 확인 / 필터 (카테고리·정렬 선택)

---

## 프로젝트 구조

```
lib/
├── main.dart                     # 앱 진입점, AppThemeMode enum, AppState (테마 관리)
├── theme/
│   ├── app_colors.dart           # 원시 색상 토큰 (Blue / Warm / Cool / Semantic 팔레트)
│   ├── semantic_colors.dart      # ThemeExtension — 커스텀 시맨틱 색상 (4가지 프리셋)
│   └── app_theme.dart            # ThemeData 빌더 (light / dark / warm / cool)
└── pages/
    └── showcase_page.dart        # 쇼케이스 메인 페이지
```

---

## 테마 아키텍처

### 색상 계층

```
AppColors                               원시 색상값 (0xFFxxxxxx)
    ↓
ColorScheme                             Material 3 표준 역할 (primary, error 등)
SemanticColors (ThemeExtension)         커스텀 역할 (success, warning, info 등)
    ↓
ThemeData.extensions                    Flutter 테마 시스템에 등록
    ↓
Theme.of(context).colorScheme           페이지에서 접근
Theme.of(context).extension<SemanticColors>()
```

### 4가지 테마 모드

| 모드 | 브랜드 색상 | 원칙 |
|---|---|---|
| **Light** | Blue 600 | 표준 Material 3 라이트 테마 |
| **Dark** | Blue 400 | 표준 Material 3 다크 테마 |
| **Warm** | Amber 600 | 모든 표면에 amber tint — 순수 흰색/회색 없음 |
| **Cool** | Cyan 600 | 모든 표면에 cyan/slate tint — 순수 흰색/회색 없음 |

#### Warm / Cool 테마 설계 원칙

> *"Premium UI never uses a pure neutral. Every surface carries a trace of the brand hue.
> Every shadow leans into the same temperature."*

- `warmNeutral0 = #FFFDF7` — 순수 `#FFFFFF` 대신 amber가 스민 흰색
- `warmNeutral200 = #E8D9C4` — 순수 `#E5E5E5` 대신 amber-tinted 테두리
- `coolNeutral0 = #F8FBFF` — 순수 `#FFFFFF` 대신 cyan이 스민 흰색
- `coolNeutral200 = #C4D4E8` — 순수 `#E5E5E5` 대신 cool-tinted 테두리
- 그림자, 테두리, 뮤트 텍스트까지 모두 같은 색온도 유지

### ColorScheme 색상 역할 매핑 (Light / Dark 기준)

| ColorScheme 역할 | 색상 | 용도 |
|---|---|---|
| `primary` / `onPrimary` | Blue 600/400 | 주 버튼, 활성 탭, 링크 |
| `primaryContainer` / `onPrimaryContainer` | Blue 50/800 | Ghost 버튼, 새로운 배지 |
| `secondary` / `onSecondary` | Teal | Teal 버튼, Extended 색상 |
| `tertiary` / `onTertiary` | Purple | 혜택 아이콘, 프리미엄 배지 |
| `tertiaryContainer` / `onTertiaryContainer` | Purple BG | 프리미엄 배지 배경 |
| `error` / `onError` | Red | Danger 버튼, 오류 알림 |
| `errorContainer` / `onErrorContainer` | Red BG | 긴급 배지, 삭제 경고 |
| `surface` / `onSurface` | White / Dark Card | 카드, 입력 필드 |
| `onSurfaceVariant` | Gray | 부제목, 날짜, 힌트 텍스트 |
| `outline` | Border Gray | 카드/입력 테두리, Divider |

### SemanticColors (ThemeExtension)

Material 3 `ColorScheme`에 없는 커스텀 색상을 `ThemeExtension`으로 확장합니다.

| 색상 | Light | Dark | Warm | Cool | 용도 |
|---|---|---|---|---|---|
| `success` | Green | Green | Green | Green | 성공 알림, 완료 배지 |
| `warning` | Amber | Amber | Amber | Amber | 경고 알림, 대기중 배지 |
| `info` | Blue | Blue | Blue | Blue | 정보 알림 |
| `pink` | Pink | Pink | Pink | Pink | 인기 배지 |
| `gradientStart/End` | Blue 600→800 | Blue 800→900 | **Amber 600→800** | **Cyan 600→800** | 잔액 카드 그라디언트 |

#### 라이트 ↔ 다크 ↔ Warm ↔ Cool 전환 시 보간

`AnimatedTheme`이 전환 애니메이션 중 `lerp()`를 호출해 색상을 부드럽게 보간합니다.

```dart
// 전환 중 t = 0.0(이전 테마) ~ 1.0(다음 테마)
gradientStart: Color.lerp(
  AppColors.warmPrimary600,   // Warm
  AppColors.coolPrimary600,   // Cool
  t,
)
```

---

## 컴포넌트 테마

모든 컴포넌트는 `ThemeData`에 등록된 테마를 자동으로 상속합니다.

| ThemeData 항목 | 적용 대상 | 처리 내용 |
|---|---|---|
| `ElevatedButtonThemeData` | 모든 ElevatedButton | shape, elevation, padding, textStyle |
| `OutlinedButtonThemeData` | 모든 OutlinedButton | shape, padding, textStyle |
| `InputDecorationTheme` | 모든 TextField | fill, border, hint 스타일, padding |
| `SwitchThemeData` | 모든 Switch | active/inactive thumb·track 색상 |
| `BottomNavigationBarThemeData` | BottomNavigationBar | 배경, 선택/미선택 색상 |
| `DividerThemeData` | 모든 Divider | 색상, 두께 |
| `DialogThemeData` | 모든 Dialog/AlertDialog | 배경색, 모서리 반경 |
| `BottomSheetThemeData` | 모든 BottomSheet | 배경색, 모서리, 드래그 핸들 |
| `TextTheme` | 모든 Text | fontSize, fontWeight, letterSpacing |

### TextTheme 스타일 정의

| TextTheme 역할 | 크기 | 굵기 | 용도 |
|---|---|---|---|
| `headlineMedium` | 26sp | w700 | 페이지 제목 |
| `titleSmall` | 15sp | w700 | 섹션 라벨, 팝업 제목 |
| `bodyLarge` | 14sp | — | TextField 입력 텍스트 |
| `bodyMedium` | 14sp | w500 | 거래 목록, 일반 본문 |
| `bodySmall` | 13sp | — | 알림 메시지, 보조 설명 |
| `labelLarge` | 13sp | w500 | 링크, 액션 텍스트 |
| `labelMedium` | 12sp | w600 | 배지 텍스트 |
| `labelSmall` | 11sp | — | 날짜, 부제목, 퀵액션 라벨 |

---

## 팝업 / 바텀 시트

### 키보드 처리

팝업·바텀 시트를 열기 전 `FocusScope.of(context).unfocus()`를 호출합니다.
모든 트리거가 `_buildOutlineChip()`을 통하므로 한 곳에서만 처리합니다.

```dart
Widget _buildOutlineChip(String label, VoidCallback onTap) => OutlinedButton(
  onPressed: () {
    FocusScope.of(context).unfocus(); // 키보드 닫기 → 팝업 열기
    onTap();
  },
  ...,
);
```

### 필터 시트 상태 관리

바텀 시트 내부 상태(카테고리 선택, 정렬)는 `StatefulBuilder`로 관리합니다.
부모 위젯을 리빌드하지 않고 시트 내부만 갱신됩니다.

```dart
showModalBottomSheet(
  builder: (ctx) => StatefulBuilder(
    builder: (ctx, setSheetState) => ...,
  ),
);
```

---

## 실행 방법

```bash
flutter pub get
flutter run
```

Flutter SDK 3.11.3 이상, Dart SDK 3.x 이상이 필요합니다.
