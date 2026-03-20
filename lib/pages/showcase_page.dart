import 'package:flutter/material.dart';
import '../main.dart';
import '../theme/app_colors.dart';
import '../theme/semantic_colors.dart';

class ShowcasePage extends StatefulWidget {
  const ShowcasePage({super.key});

  @override
  State<ShowcasePage> createState() => _ShowcasePageState();
}

class _ShowcasePageState extends State<ShowcasePage> {
  bool _notificationsEnabled = true;
  int _selectedNavIndex = 0;

  // Cached per-build theme references
  late ColorScheme _cs;
  late SemanticColors _sem;
  late TextTheme _tt;
  late bool _isDark;

  @override
  Widget build(BuildContext context) {
    _cs = Theme.of(context).colorScheme;
    _sem = Theme.of(context).extension<SemanticColors>()!;
    _tt = Theme.of(context).textTheme;
    _isDark = _cs.brightness == Brightness.dark;

    return AnimatedTheme(
      data: Theme.of(context),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      child: Scaffold(
        // backgroundColor comes from ThemeData.scaffoldBackgroundColor
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
            children: [
              _buildHeader(),
              const SizedBox(height: 22),
              _buildBalanceCard(), const SizedBox(height: 18),
              _buildQuickActions(), const SizedBox(height: 22),
              _buildSectionLabel('최근 거래', '전체보기'), const SizedBox(height: 8),
              _buildTransactionList(), const SizedBox(height: 24),
              _buildSectionLabel(_primaryRampLabel, null), const SizedBox(height: 8),
              _buildColorRamp(_primaryRamp),
              const SizedBox(height: 20),
              _buildSectionLabel('Neutral', null), const SizedBox(height: 8),
              _buildColorRamp(_neutralRamp),
              const SizedBox(height: 20),
              _buildSectionLabel('Semantic', null), const SizedBox(height: 8),
              _buildSemanticGrid(), const SizedBox(height: 20),
              _buildSectionLabel('Extended', null), const SizedBox(height: 8),
              _buildExtendedColors(), const SizedBox(height: 20),
              _buildSectionLabel('Buttons', null), const SizedBox(height: 8),
              _buildButtons(), const SizedBox(height: 20),
              _buildSectionLabel('Badges', null), const SizedBox(height: 8),
              _buildBadges(), const SizedBox(height: 20),
              _buildSectionLabel('Alerts', null), const SizedBox(height: 8),
              _buildAlerts(), const SizedBox(height: 20),
              _buildSectionLabel('Input fields', null), const SizedBox(height: 8),
              _buildInputFields(), const SizedBox(height: 20),
              _buildSectionLabel('Toggles', null), const SizedBox(height: 8),
              _buildToggles(), const SizedBox(height: 20),
              _buildSectionLabel('팝업', null), const SizedBox(height: 8),
              _buildPopups(), const SizedBox(height: 20),
              _buildSectionLabel('바텀 시트', null), const SizedBox(height: 8),
              _buildBottomSheets(),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNav(),
      ),
    );
  }

  Widget _buildHeader() => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // headlineMedium: 26sp, w700 — defined in AppTheme._textTheme
          Text('Theme Showcase', style: _tt.headlineMedium),
          const SizedBox(height: 2),
          Text('Flutter 디자인 시스템 컬러',
              style: _tt.labelSmall?.copyWith(color: _cs.onSurfaceVariant)),
        ]),
      ),
      _buildThemeToggle(),
    ],
  );

  Widget _buildThemeToggle() {
    final current = App.of(context).themeMode;
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: _cs.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _cs.outline, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: AppThemeMode.values
            .map((m) => _buildThemeChip(m, current))
            .toList(),
      ),
    );
  }

  Widget _buildThemeChip(AppThemeMode mode, AppThemeMode current) {
    final isSelected = mode == current;
    final (IconData icon, Color activeColor) = switch (mode) {
      AppThemeMode.light => (Icons.light_mode_rounded,  _cs.primary),
      AppThemeMode.dark  => (Icons.dark_mode_rounded,   _cs.onSurface),
      AppThemeMode.warm  => (Icons.wb_sunny_rounded,    _sem.warning),
      AppThemeMode.cool  => (Icons.ac_unit_rounded,     _sem.info),
    };
    return GestureDetector(
      onTap: () => App.of(context).setTheme(mode),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? _cs.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          size: 16,
          color: isSelected ? activeColor : _cs.onSurfaceVariant,
        ),
      ),
    );
  }

  // ── Theme-aware color ramps ───────────────────────────────────────────

  String get _primaryRampLabel => switch (App.of(context).themeMode) {
    AppThemeMode.warm => 'Primary amber',
    AppThemeMode.cool => 'Primary cyan',
    _                 => 'Primary blue',
  };

  List<(Color, String, Color)> get _primaryRamp =>
      switch (App.of(context).themeMode) {
    AppThemeMode.warm => [
      (AppColors.warmPrimary50,  '50',  AppColors.warmPrimary800),
      (AppColors.warmPrimary200, '200', AppColors.warmPrimary800),
      (AppColors.warmPrimary400, '400', AppColors.warmNeutral0),
      (AppColors.warmPrimary600, '600', AppColors.warmNeutral0),
      (AppColors.warmPrimary800, '800', AppColors.warmNeutral0),
      (AppColors.warmPrimary900, '900', AppColors.warmPrimary200),
    ],
    AppThemeMode.cool => [
      (AppColors.coolPrimary50,  '50',  AppColors.coolPrimary800),
      (AppColors.coolPrimary200, '200', AppColors.coolPrimary800),
      (AppColors.coolPrimary400, '400', AppColors.coolNeutral0),
      (AppColors.coolPrimary600, '600', AppColors.coolNeutral0),
      (AppColors.coolPrimary800, '800', AppColors.coolNeutral0),
      (AppColors.coolPrimary900, '900', AppColors.coolPrimary200),
    ],
    _ => [
      (AppColors.primary50,  '50',  AppColors.primary800),
      (AppColors.primary100, '100', AppColors.primary800),
      (AppColors.primary200, '200', AppColors.primary800),
      (AppColors.primary400, '400', AppColors.neutral0),
      (AppColors.primary600, '600', AppColors.neutral0),
      (AppColors.primary800, '800', AppColors.neutral0),
      (AppColors.primary900, '900', AppColors.primary200),
    ],
  };

  List<(Color, String, Color)> get _neutralRamp =>
      switch (App.of(context).themeMode) {
    AppThemeMode.warm => [
      (AppColors.warmNeutral0,   '0',   _cs.onSurfaceVariant),
      (AppColors.warmNeutral50,  '50',  _cs.onSurfaceVariant),
      (AppColors.warmNeutral200, '200', _cs.onSurface),
      (AppColors.warmNeutral400, '400', AppColors.warmNeutral0),
      (AppColors.warmNeutral600, '600', AppColors.warmNeutral0),
      (AppColors.warmNeutral900, '900', AppColors.warmNeutral400),
    ],
    AppThemeMode.cool => [
      (AppColors.coolNeutral0,   '0',   _cs.onSurfaceVariant),
      (AppColors.coolNeutral50,  '50',  _cs.onSurfaceVariant),
      (AppColors.coolNeutral200, '200', _cs.onSurface),
      (AppColors.coolNeutral400, '400', AppColors.coolNeutral0),
      (AppColors.coolNeutral600, '600', AppColors.coolNeutral0),
      (AppColors.coolNeutral900, '900', AppColors.coolNeutral400),
    ],
    AppThemeMode.dark => [
      (AppColors.darkBackground, '0',   _cs.onSurfaceVariant),
      (AppColors.darkSurface,    '50',  _cs.onSurfaceVariant),
      (AppColors.darkCard,       '200', _cs.onSurface),
      (AppColors.neutral400,     '400', AppColors.neutral0),
      (AppColors.neutral600,     '600', AppColors.neutral0),
      (AppColors.neutral800,     '800', AppColors.neutral0),
      (AppColors.neutral900,     '900', AppColors.neutral400),
    ],
    _ => [
      (AppColors.neutral0,   '0',   _cs.onSurfaceVariant),
      (AppColors.neutral50,  '50',  _cs.onSurfaceVariant),
      (AppColors.neutral200, '200', _cs.onSurface),
      (AppColors.neutral400, '400', AppColors.neutral0),
      (AppColors.neutral600, '600', AppColors.neutral0),
      (AppColors.neutral800, '800', AppColors.neutral0),
      (AppColors.neutral900, '900', AppColors.neutral400),
    ],
  };

  Widget _buildBalanceCard() => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        // gradientStart/End come from SemanticColors extension
        colors: [_sem.gradientStart, _sem.gradientEnd],
      ),
      borderRadius: BorderRadius.circular(20),
      border: _isDark
          ? Border.all(color: _cs.primary.withValues(alpha: 0.3), width: 0.5)
          : null,
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('총 자산',
          style: _tt.labelSmall?.copyWith(color: Colors.white.withValues(alpha: 0.7))),
      const SizedBox(height: 8),
      const Text('₩12,450,000',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700,
              color: Colors.white, letterSpacing: -1)),
      const SizedBox(height: 18),
      Row(children: [
        Expanded(child: _buildCardButton('보내기', Colors.white, AppColors.primary800)),
        const SizedBox(width: 10),
        Expanded(child: _buildCardButton('받기',
            Colors.white.withValues(alpha: 0.15), Colors.white)),
      ]),
    ]),
  );

  Widget _buildCardButton(String label, Color backgroundColor, Color foregroundColor) =>
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(label),
      );

  Widget _buildQuickActions() {
    final items = [
      (Icons.credit_card,     '결제',   _sem.infoContainer,    _cs.primary),
      (Icons.show_chart,      '투자',   _sem.successContainer,  _sem.success),
      (Icons.account_balance, '대출',   _sem.warningContainer,  _sem.warning),
      // tertiary = purple in ColorScheme
      (Icons.card_giftcard,   '혜택',   _cs.tertiaryContainer,  _cs.tertiary),
      (Icons.diamond,         '포인트', _sem.pinkContainer,     _sem.pink),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items.map((item) => Column(children: [
        Container(
          width: 50, height: 50,
          decoration: BoxDecoration(
            color: item.$3,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(item.$1, color: item.$4, size: 22),
        ),
        const SizedBox(height: 5),
        Text(item.$2,
            style: _tt.labelSmall?.copyWith(
                color: _cs.onSurfaceVariant, fontWeight: FontWeight.w500)),
      ])).toList(),
    );
  }

  Widget _buildTransactionList() => Container(
    decoration: BoxDecoration(
      color: _cs.surface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _cs.outline, width: 0.5),
    ),
    child: Column(children: [
      _buildTransactionItem(Icons.shopping_cart, '쿠팡',     '오늘 · 14:22', '-₩34,500',
          _cs.errorContainer, _cs.error, false),
      // height:1 with DividerThemeData(thickness:0.5) → minimal space
      const Divider(height: 1, indent: 66),
      _buildTransactionItem(Icons.savings,       '월급',     '어제 · 09:00', '+₩3,200,000',
          _sem.successContainer, _sem.success, true),
      const Divider(height: 1, indent: 66),
      _buildTransactionItem(Icons.local_cafe,    '스타벅스', '3월 18일',     '-₩5,800',
          _sem.infoContainer, _sem.info, false),
    ]),
  );

  Widget _buildTransactionItem(
    IconData icon, String name, String date, String amount,
    Color iconBackground, Color iconColor, bool isPositive,
  ) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        child: Row(children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: iconBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(name,
                  style: _tt.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
              Text(date,
                  style: _tt.labelSmall?.copyWith(color: _cs.onSurfaceVariant)),
            ]),
          ),
          Text(amount,
              style: _tt.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isPositive ? _sem.success : _cs.onSurface)),
        ]),
      );

  Widget _buildColorRamp(List<(Color, String, Color)> swatches) => Row(
    children: swatches.asMap().entries.map((entry) {
      final (color, label, textColor) = entry.value;
      return Expanded(
        child: Container(
          height: 44,
          margin: EdgeInsets.only(right: entry.key < swatches.length - 1 ? 3 : 0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: _cs.outline, width: 0.5),
          ),
          child: Center(
            child: Text(label,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: textColor)),
          ),
        ),
      );
    }).toList(),
  );

  Widget _buildSemanticGrid() {
    final items = [
      ('Success', _sem.success,  '#22C55E'),
      ('Error',   _cs.error,    '#EF4444'),
      ('Warning', _sem.warning,  '#F59E0B'),
      ('Info',    _sem.info,     '#3B82F6'),
    ];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((item) {
        final cardWidth = (MediaQuery.of(context).size.width - 48) / 2;
        return Container(
          width: cardWidth,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _cs.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _cs.outline, width: 0.5),
          ),
          child: Row(children: [
            Container(
              width: 30, height: 30,
              decoration: BoxDecoration(
                color: item.$2,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 10),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(item.$1,
                  style: _tt.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
              Text(item.$3,
                  style: _tt.labelSmall?.copyWith(color: _cs.onSurfaceVariant)),
            ]),
          ]),
        );
      }).toList(),
    );
  }

  Widget _buildExtendedColors() {
    final items = [
      ('Teal',   _cs.secondary),   // secondary = teal in ColorScheme
      ('Purple', _cs.tertiary),     // tertiary = purple in ColorScheme
      ('Pink',   _sem.pink),
      ('Orange', _sem.orange),
    ];
    return Row(
      children: items.asMap().entries.map((entry) => Expanded(
        child: Container(
          height: 52,
          margin: EdgeInsets.only(right: entry.key < items.length - 1 ? 6 : 0),
          decoration: BoxDecoration(
            color: entry.value.$2,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: Text(entry.value.$1,
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildButtons() => Wrap(spacing: 8, runSpacing: 8, children: [
    // All shape/padding/textStyle from ElevatedButtonThemeData
    // Only backgroundColor/foregroundColor overridden per-button
    ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          backgroundColor: _cs.primary, foregroundColor: _cs.onPrimary),
      child: const Text('Primary'),
    ),
    ElevatedButton(
      onPressed: () {},
      // secondary = teal
      style: ElevatedButton.styleFrom(
          backgroundColor: _cs.secondary, foregroundColor: _cs.onSecondary),
      child: const Text('Teal'),
    ),
    OutlinedButton(
      onPressed: () {},
      // Only border override; shape/padding/textStyle from OutlinedButtonThemeData
      style: OutlinedButton.styleFrom(
        foregroundColor: _cs.primary,
        side: BorderSide(color: _cs.outline, width: 0.5),
      ),
      child: const Text('Outline'),
    ),
    ElevatedButton(
      onPressed: () {},
      // primaryContainer = ghost background
      style: ElevatedButton.styleFrom(
          backgroundColor: _cs.primaryContainer,
          foregroundColor: _cs.onPrimaryContainer),
      child: const Text('Ghost'),
    ),
    ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          backgroundColor: _cs.error, foregroundColor: _cs.onError),
      child: const Text('Danger'),
    ),
  ]);

  Widget _buildBadges() {
    final items = [
      ('새로운',   _cs.primaryContainer,  _cs.onPrimaryContainer),
      ('완료',     _sem.successContainer,  _sem.onSuccessContainer),
      ('대기중',   _sem.warningContainer,  _sem.onWarningContainer),
      ('긴급',     _cs.errorContainer,     _cs.onErrorContainer),
      ('프리미엄', _cs.tertiaryContainer,  _cs.onTertiaryContainer),
      ('인기',     _sem.pinkContainer,     _sem.onPinkContainer),
    ];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((item) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: item.$2,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(item.$1,
            style: _tt.labelMedium?.copyWith(color: item.$3)),
      )).toList(),
    );
  }

  Widget _buildAlerts() => Column(children: [
    _buildAlertItem(Icons.check_circle,    '결제가 완료되었습니다',
        _sem.successContainer, _sem.onSuccessContainer),
    const SizedBox(height: 8),
    _buildAlertItem(Icons.cancel,          '인증에 실패했습니다',
        _cs.errorContainer, _cs.onErrorContainer),
    const SizedBox(height: 8),
    _buildAlertItem(Icons.warning_rounded, '잔액이 부족합니다',
        _sem.warningContainer, _sem.onWarningContainer),
    const SizedBox(height: 8),
    _buildAlertItem(Icons.info_outline,    '업데이트가 있습니다',
        _sem.infoContainer, _sem.onInfoContainer),
  ]);

  Widget _buildAlertItem(
    IconData icon, String text, Color backgroundColor, Color foregroundColor,
  ) =>
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(children: [
          Icon(icon, size: 18, color: foregroundColor),
          const SizedBox(width: 10),
          Flexible(
            child: Text(text,
                style: _tt.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500, color: foregroundColor)),
          ),
        ]),
      );

  // InputDecorationTheme handles: fill, borders, hint style, padding
  Widget _buildInputFields() => Column(children: [
    TextField(decoration: InputDecoration(hintText: '이메일 주소')),
    const SizedBox(height: 10),
    TextField(obscureText: true, decoration: InputDecoration(hintText: '비밀번호')),
  ]);

  Widget _buildToggles() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _cs.surface,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _cs.outline, width: 0.5),
    ),
    child: Column(children: [
      _buildSwitchRow('알림 받기', _notificationsEnabled,
          (value) => setState(() => _notificationsEnabled = value)),
      // DividerThemeData handles color/thickness; height is spacing
      const Divider(height: 20),
      _buildSwitchRow('다크 모드', _isDark,
          (value) => App.of(context).setTheme(
              value ? AppThemeMode.dark : AppThemeMode.light)),
    ]),
  );

  // SwitchThemeData handles all colors — no color params needed here
  Widget _buildSwitchRow(String label, bool value, ValueChanged<bool> onChanged) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: _tt.bodyMedium),
      Switch(value: value, onChanged: onChanged),
    ],
  );

  // BottomNavigationBarThemeData handles all colors — no color params needed
  Widget _buildBottomNav() => Container(
    decoration: BoxDecoration(
      border: Border(top: BorderSide(color: _cs.outline, width: 0.5)),
    ),
    child: BottomNavigationBar(
      currentIndex: _selectedNavIndex,
      onTap: (index) => setState(() => _selectedNavIndex = index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_rounded),      label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.credit_card),       label: '결제'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: '자산'),
        BottomNavigationBarItem(icon: Icon(Icons.settings),          label: '설정'),
      ],
    ),
  );

  Widget _buildSectionLabel(String title, String? action) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // titleSmall: 15sp, w700 — defined in AppTheme._textTheme
      Text(title, style: _tt.titleSmall),
      if (action != null)
        Text(action, style: _tt.labelLarge?.copyWith(color: _cs.primary)),
    ],
  );

  // ─── Popup ───────────────────────────────────────────────────────────────

  Widget _buildPopups() => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      _buildOutlineChip('기본 확인',    () => _showConfirmDialog()),
      _buildOutlineChip('성공 알림',    () => _showSemanticDialog(
          icon: Icons.check_circle_rounded,
          iconColor: _sem.success,
          containerColor: _sem.successContainer,
          title: '결제 완료',
          message: '₩34,500이 정상적으로\n결제되었습니다.',
          buttonColor: _sem.success)),
      _buildOutlineChip('오류 알림',    () => _showSemanticDialog(
          icon: Icons.cancel_rounded,
          iconColor: _cs.error,
          containerColor: _cs.errorContainer,
          title: '결제 실패',
          message: '카드 한도 초과로 결제에\n실패했습니다.',
          buttonColor: _cs.error)),
      _buildOutlineChip('경고 알림',    () => _showSemanticDialog(
          icon: Icons.warning_rounded,
          iconColor: _sem.warning,
          containerColor: _sem.warningContainer,
          title: '잔액 부족',
          message: '계좌 잔액이 부족합니다.\n충전 후 다시 시도해 주세요.',
          buttonColor: _sem.warning)),
      _buildOutlineChip('삭제 확인',    () => _showDestructiveDialog()),
      _buildOutlineChip('입력 팝업',    () => _showInputDialog()),
    ],
  );

  Widget _buildOutlineChip(String label, VoidCallback onTap) => OutlinedButton(
    onPressed: () {
      FocusScope.of(context).unfocus();
      onTap();
    },
    style: OutlinedButton.styleFrom(
      foregroundColor: _cs.primary,
      side: BorderSide(color: _cs.outline, width: 0.5),
    ),
    child: Text(label),
  );

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('변경사항 저장'),
        content: const Text('현재 변경사항을 저장하시겠습니까?\n저장하지 않으면 내용이 사라집니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(
                backgroundColor: _cs.primary, foregroundColor: _cs.onPrimary),
            child: const Text('저장'),
          ),
        ],
      ),
    );
  }

  void _showSemanticDialog({
    required IconData icon,
    required Color iconColor,
    required Color containerColor,
    required String title,
    required String message,
    required Color buttonColor,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              width: 64, height: 64,
              decoration: BoxDecoration(color: containerColor, shape: BoxShape.circle),
              child: Icon(icon, color: iconColor, size: 32),
            ),
            const SizedBox(height: 18),
            Text(title, style: _tt.titleSmall),
            const SizedBox(height: 8),
            Text(message,
                style: _tt.bodySmall?.copyWith(color: _cs.onSurfaceVariant),
                textAlign: TextAlign.center),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 46),
              ),
              child: const Text('확인'),
            ),
          ]),
        ),
      ),
    );
  }

  void _showDestructiveDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(children: [
          Icon(Icons.delete_outline_rounded, color: _cs.error, size: 22),
          const SizedBox(width: 8),
          const Text('계정 삭제'),
        ]),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _cs.errorContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(children: [
              Icon(Icons.warning_amber_rounded, color: _cs.onErrorContainer, size: 16),
              const SizedBox(width: 8),
              Flexible(
                child: Text('이 작업은 되돌릴 수 없습니다.',
                    style: _tt.labelSmall?.copyWith(color: _cs.onErrorContainer)),
              ),
            ]),
          ),
          const SizedBox(height: 12),
          Text('계정을 삭제하면 모든 데이터가 영구적으로 삭제됩니다.',
              style: _tt.bodySmall?.copyWith(color: _cs.onSurfaceVariant)),
        ]),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(
                backgroundColor: _cs.error, foregroundColor: _cs.onError),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }

  void _showInputDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('금액 입력'),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('송금할 금액을 입력해 주세요.',
              style: _tt.bodySmall?.copyWith(color: _cs.onSurfaceVariant)),
          const SizedBox(height: 16),
          TextField(
            keyboardType: TextInputType.number,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: '0',
              prefixText: '₩ ',
              suffixText: 'KRW',
            ),
          ),
        ]),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(
                backgroundColor: _cs.primary, foregroundColor: _cs.onPrimary),
            child: const Text('송금'),
          ),
        ],
      ),
    );
  }

  // ─── Bottom Sheet ────────────────────────────────────────────────────────

  Widget _buildBottomSheets() => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      _buildOutlineChip('액션 시트',   () => _showActionsSheet()),
      _buildOutlineChip('결제 확인',   () => _showPaymentSheet()),
      _buildOutlineChip('필터 시트',   () => _showFilterSheet()),
    ],
  );

  void _showActionsSheet() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        final actions = [
          (Icons.share_rounded,           '공유하기',      _cs.onSurface),
          (Icons.link_rounded,            '링크 복사',     _cs.onSurface),
          (Icons.bookmark_border_rounded, '즐겨찾기 추가', _cs.onSurface),
          (Icons.edit_outlined,           '수정하기',      _cs.onSurface),
          (Icons.flag_outlined,           '신고하기',      _cs.error),
        ];
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
                  child: Text('더보기', style: _tt.titleSmall),
                ),
                ...actions.map((item) => InkWell(
                  onTap: () => Navigator.pop(ctx),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    child: Row(children: [
                      Icon(item.$1, size: 22, color: item.$3),
                      const SizedBox(width: 16),
                      Text(item.$2, style: _tt.bodyMedium?.copyWith(color: item.$3)),
                    ]),
                  ),
                )),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPaymentSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text('결제 확인', style: _tt.titleSmall),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _cs.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(children: [
                Text('결제 금액',
                    style: _tt.labelSmall?.copyWith(color: _cs.onSurfaceVariant)),
                const SizedBox(height: 6),
                Text('₩34,500',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700,
                        color: _cs.primary, letterSpacing: -0.5)),
              ]),
            ),
            const SizedBox(height: 16),
            _buildPaymentRow('결제 수단', '국민카드 **** 1234'),
            const Divider(height: 20),
            _buildPaymentRow('결제일',   '2026.03.20'),
            const Divider(height: 20),
            _buildPaymentRow('가맹점',   '스타벅스 강남점'),
            const SizedBox(height: 24),
            Row(children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _cs.onSurface,
                    side: BorderSide(color: _cs.outline, width: 0.5),
                    minimumSize: const Size(0, 50),
                  ),
                  child: const Text('취소'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _cs.primary,
                    foregroundColor: _cs.onPrimary,
                    minimumSize: const Size(0, 50),
                  ),
                  child: const Text('결제하기'),
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }

  Widget _buildPaymentRow(String label, String value) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: _tt.bodySmall?.copyWith(color: _cs.onSurfaceVariant)),
      Text(value,  style: _tt.bodyMedium),
    ],
  );

  void _showFilterSheet() {
    var selectedCategory = 0;
    var selectedSort = 0;
    final categories = ['전체', '식비', '쇼핑', '교통', '의료'];
    final sorts = ['최신순', '오래된순', '금액 높은순', '금액 낮은순'];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('필터', style: _tt.titleSmall),
                TextButton(
                  onPressed: () => setSheetState(() {
                    selectedCategory = 0;
                    selectedSort = 0;
                  }),
                  child: Text('초기화',
                      style: _tt.labelLarge?.copyWith(color: _cs.onSurfaceVariant)),
                ),
              ]),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('카테고리',
                    style: _tt.bodySmall?.copyWith(
                        color: _cs.onSurfaceVariant, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: categories.asMap().entries.map((e) {
                  final selected = e.key == selectedCategory;
                  return GestureDetector(
                    onTap: () => setSheetState(() => selectedCategory = e.key),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: selected ? _cs.primary : _cs.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: selected ? _cs.primary : _cs.outline,
                          width: selected ? 1.5 : 0.5,
                        ),
                      ),
                      child: Text(e.value,
                          style: _tt.labelMedium?.copyWith(
                              color: selected ? _cs.onPrimary : _cs.onSurface)),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('정렬',
                    style: _tt.bodySmall?.copyWith(
                        color: _cs.onSurfaceVariant, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 10),
              ...sorts.asMap().entries.map((e) => InkWell(
                onTap: () => setSheetState(() => selectedSort = e.key),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 20, height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: e.key == selectedSort ? _cs.primary : _cs.outline,
                          width: e.key == selectedSort ? 5 : 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(e.value, style: _tt.bodyMedium),
                  ]),
                ),
              )),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _cs.primary,
                  foregroundColor: _cs.onPrimary,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('적용하기'),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
