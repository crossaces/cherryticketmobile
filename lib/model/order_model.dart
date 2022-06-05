class Order {
  final int idorder;
  final int jumlah;
  final int subtotal;
  final int idtransaksi;
  final int idtiket;

  Order({
    this.idorder,
    this.jumlah,
    this.subtotal,
    this.idtransaksi,
    this.idtiket,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        idtiket: json['ID_TIKET'],
        idorder: json['ID_ORDER'],
        idtransaksi: json['ID_TRANSAKSI'],
        jumlah: json['JUMLAH'],
        subtotal: json['SUBTOTAL']);
  }
}
