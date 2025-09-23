import React, { useState } from 'react';
import {
  Box,
  Card,
  CardContent,
  Typography,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
  Chip,
  Button,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  FormControl,
  InputLabel,
  Select,
  MenuItem,
  IconButton,
  Alert,
  CircularProgress,
  Grid,
  Divider,
} from '@mui/material';
import {
  CheckCircle,
  Cancel,
  Delete,
  Edit,
  CalendarToday,
  Person,
  Work,
  AccessTime,
} from '@mui/icons-material';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';

interface Appointment {
  id: string;
  start: string;
  end: string;
  status: 'pending' | 'approved' | 'cancelled';
  user: {
    id: string;
    name: string;
    phone: string;
    email: string;
  };
  service: {
    id: string;
    title: string;
    price: number;
  };
}

interface ServiceAvailability {
  service_id: string;
  working_hours: Record<string, string[]>;
  break_times: Array<{ start: string; end: string }>;
  is_available: boolean;
}

const API_BASE_URL = 'https://ics-backend-kn6yhrvlra-ew.a.run.app';

const AppointmentsPage: React.FC = () => {
  const [selectedAppointment, setSelectedAppointment] = useState<Appointment | null>(null);
  const [statusDialogOpen, setStatusDialogOpen] = useState(false);
  const [newStatus, setNewStatus] = useState<'approved' | 'cancelled'>('approved');
  const [availabilityDialogOpen, setAvailabilityDialogOpen] = useState(false);
  const [selectedServiceId, setSelectedServiceId] = useState<string>('');
  const [serviceAvailability, setServiceAvailability] = useState<ServiceAvailability | null>(null);
  const queryClient = useQueryClient();

  // Fetch appointments
  const { data: appointments = [], isLoading: appointmentsLoading, error: appointmentsError } = useQuery({
    queryKey: ['appointments'],
    queryFn: async () => {
      const token = localStorage.getItem('admin_token');
      const response = await fetch(`${API_BASE_URL}/appointments`, {
        headers: {
          'Authorization': `Bearer ${token}`,
        },
      });
      if (!response.ok) throw new Error('Failed to fetch appointments');
      return response.json();
    },
  });

  // Fetch services for availability management
  const { data: services = [] } = useQuery({
    queryKey: ['services'],
    queryFn: async () => {
      const response = await fetch(`${API_BASE_URL}/services`);
      if (!response.ok) throw new Error('Failed to fetch services');
      return response.json();
    },
  });

  // Update appointment status mutation
  const updateStatusMutation = useMutation({
    mutationFn: async ({ appointmentId, status }: { appointmentId: string; status: string }) => {
      const token = localStorage.getItem('admin_token');
      const formData = new FormData();
      formData.append('status', status);
      
      const response = await fetch(`${API_BASE_URL}/appointments/${appointmentId}`, {
        method: 'PUT',
        headers: {
          'Authorization': `Bearer ${token}`,
        },
        body: formData,
      });
      if (!response.ok) throw new Error('Failed to update appointment status');
      return response.json();
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['appointments'] });
      setStatusDialogOpen(false);
      setSelectedAppointment(null);
    },
  });

  // Delete appointment mutation
  const deleteAppointmentMutation = useMutation({
    mutationFn: async (appointmentId: string) => {
      const token = localStorage.getItem('admin_token');
      const response = await fetch(`${API_BASE_URL}/appointments/${appointmentId}`, {
        method: 'DELETE',
        headers: {
          'Authorization': `Bearer ${token}`,
        },
      });
      if (!response.ok) throw new Error('Failed to delete appointment');
      return response.json();
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['appointments'] });
    },
  });

  // Fetch service availability
  const { data: availability, isLoading: availabilityLoading } = useQuery({
    queryKey: ['service-availability', selectedServiceId],
    queryFn: async () => {
      if (!selectedServiceId) return null;
      const token = localStorage.getItem('admin_token');
      const response = await fetch(`${API_BASE_URL}/appointments/service-availability/${selectedServiceId}`, {
        headers: {
          'Authorization': `Bearer ${token}`,
        },
      });
      if (!response.ok) throw new Error('Failed to fetch service availability');
      return response.json();
    },
    enabled: !!selectedServiceId,
  });

  const handleStatusUpdate = (appointment: Appointment) => {
    setSelectedAppointment(appointment);
    setNewStatus(appointment.status === 'pending' ? 'approved' : 'approved');
    setStatusDialogOpen(true);
  };

  const confirmStatusUpdate = () => {
    if (selectedAppointment) {
      updateStatusMutation.mutate({
        appointmentId: selectedAppointment.id,
        status: newStatus,
      });
    }
  };

  const handleDelete = (appointmentId: string) => {
    if (window.confirm('Bu randevuyu silmek istediğinizden emin misiniz?')) {
      deleteAppointmentMutation.mutate(appointmentId);
    }
  };

  const handleAvailabilityManagement = (serviceId: string) => {
    setSelectedServiceId(serviceId);
    setAvailabilityDialogOpen(true);
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'pending': return 'warning';
      case 'approved': return 'success';
      case 'cancelled': return 'error';
      default: return 'default';
    }
  };

  const getStatusText = (status: string) => {
    switch (status) {
      case 'pending': return 'Beklemede';
      case 'approved': return 'Onaylandı';
      case 'cancelled': return 'İptal Edildi';
      default: return status;
    }
  };

  const formatDateTime = (dateTimeString: string) => {
    const date = new Date(dateTimeString);
    return {
      date: date.toLocaleDateString('tr-TR'),
      time: date.toLocaleTimeString('tr-TR', { hour: '2-digit', minute: '2-digit' }),
    };
  };

  if (appointmentsLoading) {
    return (
      <Box display="flex" justifyContent="center" alignItems="center" minHeight="400px">
        <CircularProgress />
      </Box>
    );
  }

  if (appointmentsError) {
    return (
      <Alert severity="error">
        Randevular yüklenirken hata oluştu: {appointmentsError.message}
      </Alert>
    );
  }

  return (
    <Box>
      <Typography variant="h4" gutterBottom>
        Randevu Yönetimi
      </Typography>
      
      <Grid container spacing={3}>
        {/* Statistics Cards */}
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent>
              <Typography color="textSecondary" gutterBottom>
                Toplam Randevu
              </Typography>
              <Typography variant="h4">
                {appointments.length}
              </Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent>
              <Typography color="textSecondary" gutterBottom>
                Bekleyen
              </Typography>
              <Typography variant="h4" color="warning.main">
                {appointments.filter((apt: Appointment) => apt.status === 'pending').length}
              </Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent>
              <Typography color="textSecondary" gutterBottom>
                Onaylanan
              </Typography>
              <Typography variant="h4" color="success.main">
                {appointments.filter((apt: Appointment) => apt.status === 'approved').length}
              </Typography>
            </CardContent>
          </Card>
        </Grid>
        <Grid item xs={12} md={3}>
          <Card>
            <CardContent>
              <Typography color="textSecondary" gutterBottom>
                İptal Edilen
              </Typography>
              <Typography variant="h4" color="error.main">
                {appointments.filter((apt: Appointment) => apt.status === 'cancelled').length}
              </Typography>
            </CardContent>
          </Card>
        </Grid>
      </Grid>

      <Box mt={3}>
        <Card>
          <CardContent>
            <Typography variant="h6" gutterBottom>
              Randevu Listesi
            </Typography>
            <TableContainer component={Paper}>
              <Table>
                <TableHead>
                  <TableRow>
                    <TableCell>Müşteri</TableCell>
                    <TableCell>Hizmet</TableCell>
                    <TableCell>Tarih</TableCell>
                    <TableCell>Saat</TableCell>
                    <TableCell>Durum</TableCell>
                    <TableCell>İşlemler</TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {appointments.map((appointment: Appointment) => {
                    const { date, time } = formatDateTime(appointment.start);
                    return (
                      <TableRow key={appointment.id}>
                        <TableCell>
                          <Box>
                            <Typography variant="subtitle2">
                              {appointment.user.name}
                            </Typography>
                            <Typography variant="caption" color="textSecondary">
                              {appointment.user.phone}
                            </Typography>
                          </Box>
                        </TableCell>
                        <TableCell>
                          <Typography variant="subtitle2">
                            {appointment.service.title}
                          </Typography>
                          <Typography variant="caption" color="textSecondary">
                            ₺{appointment.service.price}
                          </Typography>
                        </TableCell>
                        <TableCell>{date}</TableCell>
                        <TableCell>{time}</TableCell>
                        <TableCell>
                          <Chip
                            label={getStatusText(appointment.status)}
                            color={getStatusColor(appointment.status) as any}
                            size="small"
                          />
                        </TableCell>
                        <TableCell>
                          <IconButton
                            size="small"
                            onClick={() => handleStatusUpdate(appointment)}
                            color="primary"
                          >
                            <Edit />
                          </IconButton>
                          <IconButton
                            size="small"
                            onClick={() => handleDelete(appointment.id)}
                            color="error"
                          >
                            <Delete />
                          </IconButton>
                        </TableCell>
                      </TableRow>
                    );
                  })}
                </TableBody>
              </Table>
            </TableContainer>
          </CardContent>
        </Card>
      </Box>

      {/* Service Availability Management */}
      <Box mt={3}>
        <Card>
          <CardContent>
            <Typography variant="h6" gutterBottom>
              Hizmet Müsaitlik Yönetimi
            </Typography>
            <Grid container spacing={2}>
              {services.map((service: any) => (
                <Grid item xs={12} sm={6} md={4} key={service.id}>
                  <Card variant="outlined">
                    <CardContent>
                      <Typography variant="subtitle1" gutterBottom>
                        {service.title}
                      </Typography>
                      <Button
                        variant="outlined"
                        size="small"
                        onClick={() => handleAvailabilityManagement(service.id)}
                        startIcon={<CalendarToday />}
                      >
                        Müsaitlik Ayarları
                      </Button>
                    </CardContent>
                  </Card>
                </Grid>
              ))}
            </Grid>
          </CardContent>
        </Card>
      </Box>

      {/* Status Update Dialog */}
      <Dialog open={statusDialogOpen} onClose={() => setStatusDialogOpen(false)}>
        <DialogTitle>Randevu Durumunu Güncelle</DialogTitle>
        <DialogContent>
          {selectedAppointment && (
            <Box>
              <Typography variant="subtitle1" gutterBottom>
                Müşteri: {selectedAppointment.user.name}
              </Typography>
              <Typography variant="subtitle1" gutterBottom>
                Hizmet: {selectedAppointment.service.title}
              </Typography>
              <Typography variant="subtitle1" gutterBottom>
                Tarih: {formatDateTime(selectedAppointment.start).date}
              </Typography>
              <Typography variant="subtitle1" gutterBottom>
                Saat: {formatDateTime(selectedAppointment.start).time}
              </Typography>
              <Divider sx={{ my: 2 }} />
              <FormControl fullWidth>
                <InputLabel>Yeni Durum</InputLabel>
                <Select
                  value={newStatus}
                  onChange={(e) => setNewStatus(e.target.value as 'approved' | 'cancelled')}
                >
                  <MenuItem value="approved">Onayla</MenuItem>
                  <MenuItem value="cancelled">İptal Et</MenuItem>
                </Select>
              </FormControl>
            </Box>
          )}
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setStatusDialogOpen(false)}>İptal</Button>
          <Button
            onClick={confirmStatusUpdate}
            variant="contained"
            disabled={updateStatusMutation.isPending}
          >
            {updateStatusMutation.isPending ? <CircularProgress size={20} /> : 'Güncelle'}
          </Button>
        </DialogActions>
      </Dialog>

      {/* Service Availability Dialog */}
      <Dialog 
        open={availabilityDialogOpen} 
        onClose={() => setAvailabilityDialogOpen(false)}
        maxWidth="md"
        fullWidth
      >
        <DialogTitle>Hizmet Müsaitlik Ayarları</DialogTitle>
        <DialogContent>
          {availabilityLoading ? (
            <Box display="flex" justifyContent="center" p={3}>
              <CircularProgress />
            </Box>
          ) : availability ? (
            <Box>
              <Typography variant="h6" gutterBottom>
                Çalışma Saatleri
              </Typography>
              <Grid container spacing={2}>
                {Object.entries(availability.working_hours).map(([day, hours]) => (
                  <Grid item xs={12} sm={6} key={day}>
                    <Card variant="outlined">
                      <CardContent>
                        <Typography variant="subtitle2" gutterBottom>
                          {day.charAt(0).toUpperCase() + day.slice(1)}
                        </Typography>
                        {hours.length > 0 ? (
                          <Typography variant="body2">
                            {hours[0]} - {hours[1]}
                          </Typography>
                        ) : (
                          <Typography variant="body2" color="textSecondary">
                            Çalışmıyor
                          </Typography>
                        )}
                      </CardContent>
                    </Card>
                  </Grid>
                ))}
              </Grid>
              
              <Box mt={3}>
                <Typography variant="h6" gutterBottom>
                  Mola Saatleri
                </Typography>
                {availability.break_times.length > 0 ? (
                  availability.break_times.map((breakTime: any, index: number) => (
                    <Typography key={index} variant="body2">
                      {breakTime.start} - {breakTime.end}
                    </Typography>
                  ))
                ) : (
                  <Typography variant="body2" color="textSecondary">
                    Mola saati tanımlanmamış
                  </Typography>
                )}
              </Box>
            </Box>
          ) : (
            <Typography>Müsaitlik bilgileri yüklenemedi</Typography>
          )}
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setAvailabilityDialogOpen(false)}>Kapat</Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
};

export default AppointmentsPage;
