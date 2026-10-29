import 'package:flutter_test/flutter_test.dart';
import 'package:tanda_dolorena/modelos/participante.dart';
import 'package:tanda_dolorena/modelos/tanda.dart';
import 'package:tanda_dolorena/logica/resultado_aportacion.dart';
import 'package:tanda_dolorena/logica/resultado_cierre.dart';
import 'package:tanda_dolorena/logica/servicio_tanda.dart';

Tanda _crearTandaDePrueba() {
  return Tanda(
    participantes: [
      Participante(id: 'p1', nombre: 'Ana'),
      Participante(id: 'p2', nombre: 'Beto'),
      Participante(id: 'p3', nombre: 'Carla'),
    ],
    ordenTurnos: ['p1', 'p2', 'p3'],
    montoAportacion: 200,
  );
}


void main() {
test('simulacion completa: 3 vecinas completan una tanda de principio a fin', () {
    final tanda = _crearTandaDePrueba();
    final servicio = ServicioTanda(tanda);
    final beneficiarios = <String>[];

    while (!servicio.haTerminado()) {
      for (final p in tanda.participantes) {
        servicio.registrarAportacion(p.id);
      }
      final cierre = servicio.cerrarRondaYAvanzar();
      beneficiarios.add(cierre.beneficiario!.id);
    }

    expect(beneficiarios, ['p1', 'p2', 'p3']);
    expect(tanda.participantes.every((p) => p.yaRecibioTurno), true);
    expect(servicio.registrarAportacion('p1'), ResultadoAportacion.tandaTerminada);
  });
}

