--Un trigger que impida realizar el servicio de embalsamamiento a un difunto de más de 48 horas 
--transcurridas desde su defunción.  

CREATE OR REPLACE FUNCTION RESULTADO() RETURNS TRIGGER
AS 
$RESULTADO$
	DECLARE
		cantidad int;
		ful int = 48;
BEGIN
	select count (*) into cantidad  from fallecido where fal_id = new.fal_id;
	select causa_muerte.fal_id into ful from causa_muerte;
	if (cantidad >= ful) then
		RAISE EXCEPTION 'LO SENTIMOS NO HAY SERVICIOS DISPONIBLES';
	END if;
	RETURN new;
END;
$RESULTADO$
LANGUAGE plpgsql;

create trigger RESULTADO before insert
on fallecido for EACH ROW
execute procedure RESULTADO();

--INSERTAMOS DATOS PARA VERIFICAR EN EL TRIGGER
insert into FALLECIDO (FAL_ID, VELATORIO_ID, CMUERTE_ID, FAL_NOMBRE, FAL_APELLIDO, FAL_GENERO,
					  FAL_FECHA_NAC, FAL_DIFUNCION, FAL_HRS_DIFUNCION, FAL_HRS_EMBALSAMAMIENTO)
					  VALUES(1, 1, 1, 'Alejandrina','Muentes','Femenino','11-03-1952',
							 '29-03-2011','13:45:15','14:41:15' );