import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/features/batch/presentation/view_model/bloc/batch_bloc.dart';

class BatchView extends StatefulWidget {
  const BatchView({super.key});

  @override
  State<BatchView> createState() => _BatchViewState();
}

class _BatchViewState extends State<BatchView> {
  final TextEditingController _batchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<BatchBloc>().add(LoadBatches());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BatchBloc, BatchState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Batch Management"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // TextFormField
                TextFormField(
                  controller: _batchController,
                  decoration: const InputDecoration(
                    labelText: 'Batch Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),

                // Add Batch Button
                ElevatedButton(
                  onPressed: () {
                    final batchName = _batchController.text.trim();
                    if (batchName.isNotEmpty) {
                      context
                          .read<BatchBloc>()
                          .add(CreateBatchEvent(batchName: batchName));
                      _batchController.clear();
                    }
                  },
                  child: const Text("Add Batch"),
                ),
                const SizedBox(height: 16),
                if (state.isLoading) const CircularProgressIndicator(),
                if (state.error != null) ...[
                  Text(
                    state.error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],

                const SizedBox(height: 16),
                Expanded(
                  child: ListView.separated(
                    itemCount: state.batches.length,
                    separatorBuilder: (context, index) =>
                    const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final batch = state.batches[index];
                      return ListTile(
                        title: Text(batch.batchName),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context
                                .read<BatchBloc>()
                                .add(DeleteBatch(batchId: batch.batchId!));
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
