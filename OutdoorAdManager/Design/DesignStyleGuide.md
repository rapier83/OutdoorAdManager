# 🌈 CORA 스타일 가이드 v0.8
- Last Upadate: Apr. 19. 2025.

## 🎨 컬러 시스템
| 이름                     | 코드       | 용도              |
|--------------------------|------------|-------------------|
| `ceruleanBlue`          | `#4EA8DE`  | 메인 브랜드 컬러   |
| `signalGreen`           | `#10B981`  | 긍정, 성공         |
| `alertOrange`           | `#F97316`  | 경고, 주의         |
| `criticalRed`           | `#EF4444`  | 오류, 실패         |
| `textPrimary`           | `#111827`  | 일반 텍스트        |
| `textSecondary`         | `#374151`  | 서브 텍스트        |
| `divider`               | `#D1D5DB`  | 구분선             |
| `background`            | `#F9FAFB`  | 앱 배경             |
| `cardBackground`        | `#FFFFFF`  | 카드 UI 배경       |
| `hoverBackground`       | `#E5E7EB`  | 버튼 Hover 효과     |
| `primaryButtonText`     | `#FFFFFF`  | 메인 버튼 텍스트   |

---

## 🧱 재사용 UI 컴포넌트

### 🔹 `BaseCardView`
- 기본 둥근 그림자 카드형 컨테이너
- 배경색: `cardBackground`
- 모서리 반경: 16
- 그림자: 검정 5% 투명도, y-offset 2

### 🔹 `PrimaryButton`
- 높이 50
- 배경: `ceruleanBlue`
- 텍스트색: `primaryButtonText`
- cornerRadius: 12

### 🔹 `HeadlineLabel`
- 글꼴: `system 20, semibold`
- 색상: `textPrimary`

### 🔹 `InfoLabel`
- 글꼴: `system 13`
- 색상: `textSecondary`

### 🔹 `ToastView`
- 배경: `black alpha 0.8`
- cornerRadius: 8
- 하단 중앙 표시, 사라짐 애니메이션 포함

### 🔹 `RoundedImageView`
- 정사각형 이미지 뷰를 원형으로 렌더링

### 🔹 `SectionTitleView`
- 섹션 구분용 헤더 텍스트
- `system 18, semibold`, `textPrimary`

---

## 🧩 페이지별 UI 스타일 요약

### 📋 DashBoardViewController
- 배경색: `background`
- 카드: `BaseCardView`
- 버튼: `PrimaryButton`
- 제목: `HeadlineLabel`
- 통계: `InfoLabel`

### 📍 MediaSiteListViewController
- 셀:
  - 제목: `textPrimary`, 굵게
  - 서브: 인구 밀도/날씨 → `InfoLabel`

### 📺 MediaScreenListViewController
- 셀:
  - 이름: `HeadlineLabel`
  - 상태/밝기/비용: `InfoLabel`

### 📣 AdCampaignListViewController
- 카드형 셀 추천
  - 타이틀: `HeadlineLabel`
  - 설명/예산: `InfoLabel`

### 🛰️ RecommendationResultViewController
- 상단 제목: `HeadlineLabel`
- 리스트 셀: 추천 전광판 정보 (효율 포함)

### 🧾 LogsViewController
- 토스트 or AlertView 로 로그 표시

---

## 📌 기타
- 텍스트 스타일은 되도록 **SF Font 기준**으로 유지
- 모든 뷰는 `safeAreaLayoutGuide`에 맞춰 오토레이아웃 적용

---

버전: `0.8`
작성일: 2025-04-19
작성자: All System

