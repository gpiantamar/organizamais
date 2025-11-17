import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/task_controller.dart';
import '../model/task.dart';

class AddTaskScreen extends StatefulWidget {
  final Task? task;

  const AddTaskScreen({super.key, this.task});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  Priority _selectedPriority = Priority.medium;
  bool _isHabit = false;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController = TextEditingController(text: widget.task!.title);
      _descriptionController =
          TextEditingController(text: widget.task!.description);
      _selectedPriority = widget.task!.priority;
      _isHabit = widget.task!.isHabit;
    } else {
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Tarefa' : 'Nova Tarefa'),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Campo Título
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
                hintText: 'Digite o título da tarefa',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Por favor, insira um título';
                }
                return null;
              },
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),

            // Campo Descrição
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                hintText: 'Digite a descrição da tarefa (opcional)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 24),

            // Prioridade
            Text(
              'Prioridade',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            SegmentedButton<Priority>(
              segments: [
                ButtonSegment<Priority>(
                  value: Priority.low,
                  label: Text(Priority.low.label),
                  icon: Icon(Icons.arrow_downward, size: 18),
                ),
                ButtonSegment<Priority>(
                  value: Priority.medium,
                  label: Text(Priority.medium.label),
                  icon: Icon(Icons.remove, size: 18),
                ),
                ButtonSegment<Priority>(
                  value: Priority.high,
                  label: Text(Priority.high.label),
                  icon: Icon(Icons.arrow_upward, size: 18),
                ),
              ],
              selected: {_selectedPriority},
              onSelectionChanged: (Set<Priority> newSelection) {
                setState(() {
                  _selectedPriority = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 24),

            // Switch Hábito
            Card(
              child: SwitchListTile(
                title: const Text('Hábito Recorrente'),
                subtitle: const Text(
                  'Marque se esta tarefa é um hábito que se repete diariamente',
                ),
                value: _isHabit,
                onChanged: (value) {
                  setState(() {
                    _isHabit = value;
                  });
                },
                secondary: const Icon(Icons.repeat),
              ),
            ),
            const SizedBox(height: 32),

            // Botão Salvar
            ElevatedButton.icon(
              onPressed: _saveTask,
              icon: const Icon(Icons.save),
              label: Text(isEditing ? 'Salvar Alterações' : 'Criar Tarefa'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveTask() async {
    if (_formKey.currentState!.validate()) {
      final controller = Provider.of<TaskController>(context, listen: false);

      if (widget.task != null) {
        // Editar tarefa existente
        final updatedTask = widget.task!.copyWith(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          priority: _selectedPriority,
          isHabit: _isHabit,
        );
        await controller.updateTask(updatedTask);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tarefa atualizada com sucesso!'),
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.pop(context);
        }
      } else {
        // Criar nova tarefa
        final newTask = Task(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          priority: _selectedPriority,
          isHabit: _isHabit,
          createdAt: DateTime.now(),
        );
        await controller.addTask(newTask);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tarefa criada com sucesso!'),
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.pop(context);
        }
      }
    }
  }
}

