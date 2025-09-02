import React from 'react';
import {
  Paper,
  Typography,
  Card,
  CardContent,
  Box,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
} from '@mui/material';
import {
  TrendingUp,
  ShoppingCart,
  People,
  AttachMoney,
} from '@mui/icons-material';

interface StatCardProps {
  title: string;
  value: string;
  icon: React.ReactNode;
  color: string;
}

const StatCard: React.FC<StatCardProps> = ({ title, value, icon, color }) => (
  <Card>
    <CardContent>
      <Box display="flex" alignItems="center" justifyContent="space-between">
        <Box>
          <Typography color="textSecondary" gutterBottom variant="body2">
            {title}
          </Typography>
          <Typography variant="h4" component="h2">
            {value}
          </Typography>
        </Box>
        <Box sx={{ color, fontSize: 40 }}>
          {icon}
        </Box>
      </Box>
    </CardContent>
  </Card>
);

const Dashboard: React.FC = () => {
  const stats = [
    {
      title: 'Toplam Satış',
      value: '₺45,280',
      icon: <AttachMoney />,
      color: '#4caf50',
    },
    {
      title: 'Siparişler',
      value: '127',
      icon: <ShoppingCart />,
      color: '#2196f3',
    },
    {
      title: 'Müşteriler',
      value: '89',
      icon: <People />,
      color: '#ff9800',
    },
    {
      title: 'Büyüme',
      value: '+12%',
      icon: <TrendingUp />,
      color: '#9c27b0',
    },
  ];

  const recentOrders = [
    { id: '#001', customer: 'Ahmet Yılmaz', total: '₺250', status: 'Tamamlandı' },
    { id: '#002', customer: 'Fatma Kaya', total: '₺180', status: 'Beklemede' },
    { id: '#003', customer: 'Mehmet Öz', total: '₺320', status: 'İptal' },
    { id: '#004', customer: 'Ayşe Demir', total: '₺95', status: 'Tamamlandı' },
  ];

  return (
    <Box>
      <Typography variant="h4" gutterBottom>
        Dashboard
      </Typography>
      
      {/* Stats Cards using Box Grid */}
      <Box 
        sx={{ 
          display: 'grid',
          gridTemplateColumns: { 
            xs: '1fr', 
            sm: '1fr 1fr', 
            md: 'repeat(4, 1fr)' 
          },
          gap: 3,
          mb: 3 
        }}
      >
        {stats.map((stat, index) => (
          <StatCard key={index} {...stat} />
        ))}
      </Box>

      {/* Main Content using Flexbox */}
      <Box sx={{ 
        display: 'flex', 
        flexDirection: { xs: 'column', md: 'row' },
        gap: 3 
      }}>
        {/* Orders Table */}
        <Box sx={{ flex: 2 }}>
          <Paper sx={{ p: 2 }}>
            <Typography variant="h6" gutterBottom>
              Son Siparişler
            </Typography>
            <TableContainer>
              <Table>
                <TableHead>
                  <TableRow>
                    <TableCell>Sipariş ID</TableCell>
                    <TableCell>Müşteri</TableCell>
                    <TableCell>Toplam</TableCell>
                    <TableCell>Durum</TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {recentOrders.map((order) => (
                    <TableRow key={order.id}>
                      <TableCell>{order.id}</TableCell>
                      <TableCell>{order.customer}</TableCell>
                      <TableCell>{order.total}</TableCell>
                      <TableCell>
                        <Typography
                          variant="body2"
                          sx={{
                            color:
                              order.status === 'Tamamlandı'
                                ? 'success.main'
                                : order.status === 'Beklemede'
                                ? 'warning.main'
                                : 'error.main',
                          }}
                        >
                          {order.status}
                        </Typography>
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </TableContainer>
          </Paper>
        </Box>
        
        {/* Quick Access Sidebar */}
        <Box sx={{ flex: 1 }}>
          <Paper sx={{ p: 2 }}>
            <Typography variant="h6" gutterBottom>
              Hızlı Erişim
            </Typography>
            <Box sx={{ mt: 2 }}>
              <Typography variant="body2" color="text.secondary">
                • Yeni ürün ekle
              </Typography>
              <Typography variant="body2" color="text.secondary" sx={{ mt: 1 }}>
                • Sipariş yönetimi
              </Typography>
              <Typography variant="body2" color="text.secondary" sx={{ mt: 1 }}>
                • Müşteri destek
              </Typography>
              <Typography variant="body2" color="text.secondary" sx={{ mt: 1 }}>
                • Raporlar
              </Typography>
            </Box>
          </Paper>
        </Box>
      </Box>
    </Box>
  );
};

export default Dashboard;