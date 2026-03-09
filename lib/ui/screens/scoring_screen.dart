import 'package:flutter/material.dart';
import '../../data/models/match.dart' as app_models;
import '../../data/services/match_service.dart';
import '../../data/services/event_service.dart';

class ScoringScreen extends StatefulWidget {
  final String matchId;
  const ScoringScreen({super.key, required this.matchId});

  @override
  State<ScoringScreen> createState() => _ScoringScreenState();
}

class _ScoringScreenState extends State<ScoringScreen> {
  final MatchService _matchService = MatchService();
  final EventService _eventService = EventService();

  int _selectedRuns = 0;
  bool _isWicket = false;
  final TextEditingController _descriptionController = TextEditingController();
  
  bool _isSubmitting = false;

  Future<void> _submitEvent() async {
    setState(() => _isSubmitting = true);
    try {
      await _eventService.addEventAndUpdateScore(
        matchId: widget.matchId,
        runs: _selectedRuns,
        isWicket: _isWicket,
        description: _descriptionController.text.trim().isNotEmpty 
            ? _descriptionController.text.trim() 
            : null,
      );
      
      // Reset form on success
      if (mounted) {
        setState(() {
          _selectedRuns = 0;
          _isWicket = false;
          _descriptionController.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event added successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add event: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Score Match'),
        backgroundColor: Colors.amber.shade200,
      ),
      body: StreamBuilder<app_models.MatchModel?>(
        stream: _matchService.getMatchById(widget.matchId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final match = snapshot.data;
          if (match == null) {
            return const Center(child: Text('Match not found.'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildLiveScoreBanner(match),
                const SizedBox(height: 32),
                const Text('Record Next Ball', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Divider(),
                const SizedBox(height: 16),
                _buildRunsSelector(),
                const SizedBox(height: 24),
                _buildWicketToggle(),
                const SizedBox(height: 24),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description (Optional)',
                    hintText: 'e.g., Clean bowled, Great catch',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitEvent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber.shade700,
                      foregroundColor: Colors.white,
                    ),
                    child: _isSubmitting 
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('SUBMIT EVENT', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLiveScoreBanner(app_models.MatchModel match) {
    // Determine which team is batting to highlight their score
    final isTeamABatting = match.currentInnings == 1;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            '${match.teamAId} vs ${match.teamBId}',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _scoreBlock(match.teamAId, match.scoreA, isTeamABatting),
              const Text('+', style: TextStyle(color: Colors.white38, fontSize: 24)),
              _scoreBlock(match.teamBId, match.scoreB, !isTeamABatting),
            ],
          ),
        ],
      ),
    );
  }

  Widget _scoreBlock(String team, app_models.MatchScore score, bool isBatting) {
    return Column(
      children: [
        Text(
          '${score.runs}/${score.wickets}',
          style: TextStyle(
            color: isBatting ? Colors.amber : Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '(${score.overs})',
          style: TextStyle(color: isBatting ? Colors.amber.shade200 : Colors.white54, fontSize: 14),
        )
      ],
    );
  }

  Widget _buildRunsSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Runs Scored:', style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: [0, 1, 2, 3, 4, 6].map((runValue) {
            final isSelected = _selectedRuns == runValue;
            return ChoiceChip(
              label: Text('$runValue', style: const TextStyle(fontSize: 18)),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) setState(() => _selectedRuns = runValue);
              },
              selectedColor: Colors.amber.shade300,
              backgroundColor: Colors.grey.shade200,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildWicketToggle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: _isWicket ? Colors.red : Colors.grey.shade300, width: 2),
        borderRadius: BorderRadius.circular(8),
        color: _isWicket ? Colors.red.shade50 : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Wicket?',
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold, 
              color: _isWicket ? Colors.red.shade900 : Colors.black87
            ),
          ),
          Switch(
            value: _isWicket,
            activeThumbColor: Colors.red,
            onChanged: (val) => setState(() => _isWicket = val),
          ),
        ],
      ),
    );
  }
}
