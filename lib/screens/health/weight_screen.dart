import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'edit_weight_screen.dart';
import 'add_weight_screen.dart';
import '../../services/weight_service.dart';
import '../../models/pet_model.dart';

class WeightScreen extends StatefulWidget {
  final Pet pet;

  const WeightScreen({super.key, required this.pet});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  List<FlSpot> getChartData(List weightList) {
    List<FlSpot> spots = [];

    for (int i = 0; i < weightList.length; i++) {
      double weight = double.parse(weightList[i].weight.replaceAll(" kg", ""));

      spots.add(FlSpot(i.toDouble(), weight));
    }

    return spots;
  }

  double getMinWeight(List weightList) {
    if (weightList.isEmpty) {
      return 0;
    }

    double min = double.parse(weightList[0].weight.replaceAll(" kg", ""));

    for (var item in weightList) {
      double value = double.parse(item.weight.replaceAll(" kg", ""));

      if (value < min) {
        min = value;
      }
    }

    return min - 1;
  }

  double getMaxWeight(List weightList) {
    if (weightList.isEmpty) {
      return 10;
    }

    double max = double.parse(weightList[0].weight.replaceAll(" kg", ""));

    for (var item in weightList) {
      double value = double.parse(item.weight.replaceAll(" kg", ""));

      if (value > max) {
        max = value;
      }
    }

    return max + 1;
  }

  @override
  Widget build(BuildContext context) {
    final weightList = WeightService.weightList
        .where((item) => item.petId == widget.pet.id)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text("Cân nặng - ${widget.pet.name}")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // THÔNG TIN PET
            Card(
              child: ListTile(
                leading: const Icon(Icons.pets, size: 40),

                title: Text(
                  widget.pet.name,

                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: Text("${widget.pet.species} - ${widget.pet.breed}"),

                trailing: Text(
                  "${widget.pet.weight} kg",

                  style: const TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),

                label: const Text("Thêm cân nặng"),

                onPressed: () async {
                  await Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (_) => AddWeightScreen(pet: widget.pet),
                    ),
                  );

                  setState(() {});
                },
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Biểu đồ cân nặng",

              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 220,

              child: weightList.isEmpty
                  ? const Center(child: Text("Chưa có dữ liệu"))
                  : LineChart(
                      LineChartData(
                        minX: 0,

                        maxX: (weightList.length - 1).toDouble(),

                        minY: getMinWeight(weightList),

                        maxY: getMaxWeight(weightList),

                        gridData: const FlGridData(show: true),

                        lineBarsData: [
                          LineChartBarData(
                            spots: getChartData(weightList),

                            isCurved: true,

                            barWidth: 3,

                            dotData: const FlDotData(show: true),
                          ),
                        ],
                      ),
                    ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Lịch sử cân nặng",

              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: weightList.length,

                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.monitor_weight,
                        color: Colors.teal,
                      ),

                      title: Text(weightList[index].date),

                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            weightList[index].weight,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),

                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == "edit") {
                                Navigator.push(
                                  context,

                                  MaterialPageRoute(
                                    builder: (_) => EditWeightScreen(
                                      weight: weightList[index],
                                    ),
                                  ),
                                ).then((value) {
                                  setState(() {});
                                });
                              }

                              if (value == "delete") {
                                setState(() {
                                  WeightService.weightList.remove(
                                    weightList[index],
                                  );
                                });
                              }
                            },

                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: "edit",

                                child: Row(
                                  children: [
                                    Icon(Icons.edit, color: Colors.blue),

                                    SizedBox(width: 10),

                                    Text("Chỉnh sửa"),
                                  ],
                                ),
                              ),

                              const PopupMenuItem(
                                value: "delete",

                                child: Row(
                                  children: [
                                    Icon(Icons.delete, color: Colors.red),

                                    SizedBox(width: 10),

                                    Text("Xóa"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
