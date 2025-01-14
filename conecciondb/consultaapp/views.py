from django.shortcuts import render
from .models import Pedidos, Productos, Usuarios

def my_table_view(request):
    pedidos = Pedidos.objects.all()
    productos = Productos.objects.all()
    usuarios = Usuarios.objects.all()
    return render(request, 'consultaapp/my_table.html', {
        'pedidos': pedidos,
        'productos': productos,
        'usuarios': usuarios
    })