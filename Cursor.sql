--Un cursor que muestre los ingresos obtenidos por servicio de todos los vendedores. 
do $$
declare 
	contador int =0;
	total Record;

--INICIO DEL CURSOR
	totalservicios Cursor for select * from empleado,tipo_empleado,servicio
	where servicio.ser_id = servicio.ser_id and
	empleado.tipo_id = 1;
begin
	for total in totalservicios loop
	contador = contador+count(total.ser_id);
	
Raise Notice 'empleado: %, servicio: %, costo_total: %',
total.tipo_id,total.ser_id, total.ser_costototal;
end loop;
end $$
Language 'plpgsql';