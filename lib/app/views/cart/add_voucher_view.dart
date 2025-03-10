import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddVoucherView extends StatelessWidget {
  const AddVoucherView({super.key});

  void show() {
    showModalBottomSheet(
      context: navigator!.context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return this;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Active Vouchers",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Voucher List
          _buildVoucherCard(
            title: "First Purchase",
            subtitle: "5% off for your next order",
            validUntil: "5.16.20",
          ),
          const SizedBox(height: 12),
          _buildVoucherCard(
            title: "Gift From Customer Care",
            subtitle: "15% off your next purchase",
            validUntil: "6.20.20",
          ),
        ],
      ),
    );
  }

  Widget _buildVoucherCard({
    required String title,
    required String subtitle,
    required String validUntil,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Voucher",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Valid Until $validUntil",
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.card_giftcard, color: Colors.blue),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text("Apply"),
            ),
          ),
        ],
      ),
    );
  }
}

void showVoucherBottomSheet(BuildContext context) {}
