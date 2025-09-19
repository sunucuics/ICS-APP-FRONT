import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/admin_analytics_provider.dart';
import '../widgets/admin_navigation.dart';
import '../../../../core/theme/app_theme.dart';

class AdminAnalyticsPage extends ConsumerStatefulWidget {
  const AdminAnalyticsPage({super.key});

  @override
  ConsumerState<AdminAnalyticsPage> createState() => _AdminAnalyticsPageState();
}

class _AdminAnalyticsPageState extends ConsumerState<AdminAnalyticsPage> {
  String _selectedPeriod = 'week';
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  Widget build(BuildContext context) {
    final analyticsAsync = ref.watch(adminAnalyticsProvider({
      'period': _selectedPeriod,
      'startDate': _startDate,
      'endDate': _endDate,
    }));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics & Raporlama'),
        backgroundColor: AppTheme.primaryNavy,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await ref.refresh(adminAnalyticsProvider({
                'period': _selectedPeriod,
                'startDate': _startDate,
                'endDate': _endDate,
              }));
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedPeriod = value;
                _startDate = null;
                _endDate = null;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'today', child: Text('Bugün')),
              const PopupMenuItem(value: 'week', child: Text('Bu Hafta')),
              const PopupMenuItem(value: 'month', child: Text('Bu Ay')),
              const PopupMenuItem(value: 'year', child: Text('Bu Yıl')),
              const PopupMenuItem(value: 'custom', child: Text('Özel Tarih')),
            ],
            child: const Icon(Icons.date_range),
          ),
        ],
      ),
      body: analyticsAsync.when(
        data: (analyticsData) => _buildAnalyticsContent(context, analyticsData),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _buildErrorWidget(context, error.toString()),
      ),
      bottomNavigationBar: const AdminNavigation(),
    );
  }

  Widget _buildAnalyticsContent(BuildContext context, analyticsData) {
    return RefreshIndicator(
      onRefresh: () async {
        await ref.refresh(adminAnalyticsProvider({
          'period': _selectedPeriod,
          'startDate': _startDate,
          'endDate': _endDate,
        }));
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPeriodSelector(),
            const SizedBox(height: 24),
            _buildSalesOverview(analyticsData.salesReport),
            const SizedBox(height: 24),
            _buildUserActivity(analyticsData.userActivity),
            const SizedBox(height: 24),
            _buildRevenueChart(analyticsData.revenueChart),
            const SizedBox(height: 24),
            _buildTrendAnalysis(analyticsData.trendAnalysis),
            const SizedBox(height: 24),
            _buildExportSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Zaman Aralığı',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryNavy,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedPeriod,
                    decoration: const InputDecoration(
                      labelText: 'Periyot',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'today', child: Text('Bugün')),
                      DropdownMenuItem(value: 'week', child: Text('Bu Hafta')),
                      DropdownMenuItem(value: 'month', child: Text('Bu Ay')),
                      DropdownMenuItem(value: 'year', child: Text('Bu Yıl')),
                      DropdownMenuItem(
                          value: 'custom', child: Text('Özel Tarih')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedPeriod = value!;
                        if (value != 'custom') {
                          _startDate = null;
                          _endDate = null;
                        }
                      });
                    },
                  ),
                ),
                if (_selectedPeriod == 'custom') ...[
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextButton.icon(
                      onPressed: _selectDateRange,
                      icon: const Icon(Icons.calendar_today),
                      label: Text(_startDate != null && _endDate != null
                          ? '${_startDate!.day}/${_startDate!.month} - ${_endDate!.day}/${_endDate!.month}'
                          : 'Tarih Seç'),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesOverview(salesReport) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Satış Özeti',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryNavy,
                  ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildMetricCard(
                  'Toplam Satış',
                  '₺${salesReport.totalSales.toStringAsFixed(2)}',
                  Icons.attach_money,
                  Colors.green,
                ),
                _buildMetricCard(
                  'Toplam Sipariş',
                  salesReport.totalOrders.toString(),
                  Icons.shopping_cart,
                  Colors.blue,
                ),
                _buildMetricCard(
                  'Ortalama Sipariş',
                  '₺${salesReport.averageOrderValue.toStringAsFixed(2)}',
                  Icons.trending_up,
                  Colors.orange,
                ),
                _buildMetricCard(
                  'Dönüşüm Oranı',
                  '${salesReport.conversionRate.toStringAsFixed(1)}%',
                  Icons.percent,
                  Colors.purple,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserActivity(userActivity) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kullanıcı Aktivitesi',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryNavy,
                  ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildMetricCard(
                  'Toplam Kullanıcı',
                  userActivity.totalUsers.toString(),
                  Icons.people,
                  Colors.blue,
                ),
                _buildMetricCard(
                  'Yeni Kullanıcı',
                  userActivity.newUsers.toString(),
                  Icons.person_add,
                  Colors.green,
                ),
                _buildMetricCard(
                  'Aktif Kullanıcı',
                  userActivity.activeUsers.toString(),
                  Icons.person,
                  Colors.orange,
                ),
                _buildMetricCard(
                  'Tutma Oranı',
                  '${userActivity.retentionRate.toStringAsFixed(1)}%',
                  Icons.trending_up,
                  Colors.purple,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRevenueChart(revenueChart) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gelir Grafiği',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryNavy,
                  ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bar_chart,
                      size: 48,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Gelir Grafiği',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${revenueChart.labels.length} veri noktası',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendAnalysis(trendAnalysis) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trend Analizi',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryNavy,
                  ),
            ),
            const SizedBox(height: 16),
            _buildTrendItem(
                'Satış Trendi', trendAnalysis.salesTrend, Icons.trending_up),
            _buildTrendItem(
                'Kullanıcı Trendi', trendAnalysis.userTrend, Icons.people),
            _buildTrendItem('Sipariş Trendi', trendAnalysis.orderTrend,
                Icons.shopping_cart),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendItem(String title, double trend, IconData icon) {
    final isPositive = trend >= 0;
    final color = isPositive ? Colors.green : Colors.red;
    final trendIcon = isPositive ? Icons.trending_up : Icons.trending_down;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryNavy),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Row(
            children: [
              Icon(trendIcon, color: color, size: 20),
              const SizedBox(width: 4),
              Text(
                '${trend.toStringAsFixed(1)}%',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExportSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rapor İndir',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryNavy,
                  ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _exportReport('csv'),
                    icon: const Icon(Icons.file_download),
                    label: const Text('CSV İndir'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryOrange,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _exportReport('pdf'),
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text('PDF İndir'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: color.withOpacity(0.8),
                ),
              ),
              Icon(icon, color: color, size: 20),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 16),
          Text(
            'Hata oluştu: $error',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ref.invalidate(adminAnalyticsProvider({
                'period': _selectedPeriod,
                'startDate': _startDate,
                'endDate': _endDate,
              }));
            },
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: _startDate != null && _endDate != null
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  Future<void> _exportReport(String format) async {
    try {
      await ref
          .read(adminAnalyticsNotifierProvider.notifier)
          .exportReport(format);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$format formatında rapor indiriliyor...'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Rapor indirme hatası: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
